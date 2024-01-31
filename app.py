from ingredients.bottle import Bottle, route, run, template, static_file, TEMPLATE_PATH, request, response, redirect
from ingredients import files, schnorr, members
from datetime import date, datetime
import json
import os
import secrets

app = Bottle()
path = '/' # How to get to this module from the root
name = "Greenspots"
description = "Support Sustainability! A map of ecologically conscious local businesses."
image_full = f'{path}static/images/full.png'
image_thumb = f'{path}static/images/thumb.png'
station = "localhost"
public = True

TEMPLATE_PATH.append(f'potions/greenspots/views')

# This may need to be configured
static_path = '/static/'

os.makedirs('data/members', exist_ok=True)
os.makedirs('data/spots', exist_ok=True)
os.makedirs('data/visitors', exist_ok=True)

active_members = members.MembersList('data/members')

sessions = {}

def member_from_cookie():
    nsec = request.get_cookie('nsec')
    if nsec:
        npub = schnorr.pubkey_gen_from_hex(nsec).hex()
        response.delete_cookie('nsec', path="/")
        response.delete_cookie('npub', path="/")
        response.set_cookie('nsec', nsec, maxage=3600, path="/")
        response.set_cookie('npub', npub, maxage=3600, path="/")
        member = active_members.get(npub)
    else:
        member = None

    return member

def get_visitor_data():
    visitors = {}

    ips = files.load_dir('data/visitors')
    for entry in ips:
        visitors[entry['address']] = entry['visits']

    return visitors

def get_spot_data(disabled=False, owner=None):
    spots = []
    spot_posts = files.load_dir('data/spots')
    for post in spot_posts:
        if not disabled and post.get('enabled') == "false":
            continue

        if owner is not None and post.get('owner') != owner:
            continue

        spots.append(dict(post))

    return spots

def validate_session(pubkey, session_key):
    now = datetime.now()

    # Clean up sessions older than 10 hours
    for existing_session in sessions.items():
        if (now - existing_session[1]['created']).seconds > 36000:
            del sessions[existing_session[0]]

    member = active_members.get(pubkey)
    session = sessions.get(member.get('name'))

    if session is None:
        return False

    if session['key'] == session_key:
        session['created'] = now
        return True
    else:
        return False

def process_visitor(ip : str):
    try:
        user = files.load(f'data/visitors/{ip}')
    except FileNotFoundError:
        user = None

    today = date.today()

    # If there is no user, then we add them!
    if user is None:
        print('new user: ', ip)
        files.make_file({"address": ip, "visits": [str(today)]}, f'This tree was planted {today}',f'data/visitors/{ip}')

    # otherwise we see if we need to add to their visit count
    else:
        print('existing user: ', ip)
        last_visit = date.fromisoformat(user['visits'][-1])
        if last_visit != today:
            user['visits'].append(str(today))
            files.update_file({'visits': user['visits']}, f'data/visitors/{ip}')

def ip_tracker():
    # First, we parse the IP of whoever is making the request
    if request.environ.get('HTTP_X_REAL_IP'):
        ip = request.environ.get('HTTP_X_REAL_IP')
    else:
        ip = request.remote_addr

    # We pass the IP to a processing function
    process_visitor(ip)

    # After that, we get an updated visit count
    visit_count = get_visitor_data()

    return {
            "length": len(visit_count),
            "data": visit_count,
            "user": ip
            }

def newFileEvent(pubkey, name, file):

    if file.content_type.startswith('image'):
        path = f'u/{name}/images'
        # Create the blurhash here

    elif file.content_type.startswith('audio'):
        path = f'u/{name}/audio'
    elif file.content_type.startswith('markdown'):
        path = f'u/{name}/posts'
    else:
        path = f'u/{name}/assets'

    try:
        os.makedirs("data/" + path, exist_ok=True)
        file.save("data/" + path)
    except IOError as e:
        print('error: ', e)
        pass

    e = {
        'content': file.filename,
        'pubkey': pubkey,
        'kind': 1063,
        'created_at': round(datetime.now().timestamp()),
        'tags': [
            ['url',f'https://{station}/{path}/{file.filename}'],
            ['m',file.content_type],
            ['x', schnorr.sha256(file.file.read()).hex()]
        ]
    }

    return e;

def defaults():
    return {
            "member": member_from_cookie(),
            "static_path": static_path,
            "lang": request.get_cookie('lang') or 'en',
            "coords": [20.87, -105.44],
            "spots": get_spot_data(disabled=True),
            "trees": ip_tracker()
    }

@app.post('/register')
def register_post():
    name = request.forms.get('name')
    email = request.forms.get('email')
    nsec = request.forms.get('nsec')

    member_data = {
        "name": name,
        "email": email,
        "secret_key": nsec or None,
        "realms": ["private"],
    }

    active_members.new(member_data, name)

    # Log a user in when they register
    nsec = active_members.login(name, name)
    key = secrets.token_hex(24)
    sessions[name] = { "key": key, "created": datetime.now() }
    response.set_cookie('nsec', nsec, maxage=36000, path="/")
    response.set_cookie('npub', schnorr.pubkey_gen_from_hex(nsec).hex(), maxage=36000, path="/")
    response.set_cookie('session', key, maxage=36000, path="/")

    return redirect('/')
    
@app.post('/login')
def login_post():
    name = request.forms.get('name')
    password = request.forms.get('password')
    result = active_members.login(name, password)
    redir = request.forms.get('redirect')
    if result:
        key = secrets.token_hex(24)
        sessions[name] = { "key": key, "created": datetime.now() }
        response.set_cookie('nsec', result, maxage=36000, path="/")
        response.set_cookie('npub', schnorr.pubkey_gen_from_hex(result).hex(), maxage=36000, path="/")
        response.set_cookie('session', key, maxage=36000, path="/")

        prev = request.forms.get('redirect')
        return redirect(prev)

    return template("greenspots/login.tpl", error="Login Failed", redir=redir, **defaults())

@app.get('/.well-known/nostr.json')
def list_members():
    member_cards = load_dir('data/members')
    memberDictionary = {
        'names': {},
        'admins': []
    }

    for card in member_cards:
        memberDictionary['names'][card.metadata['name']] = card.metadata.get('public_key')

        if "admin" in card.get('realms'):
            memberDictionary['admins'].append(card.metadata.get('public_key'))

    return json.dumps(memberDictionary)

@app.get('/lang/<lang>')
def setlang(lang):
    response.set_cookie('lang', lang, path='/')
    redirect(request.environ.get('HTTP_REFERER'))

@app.post('/new_upload')
def invite_post():
    npub = request.get_cookie('npub')
    if npub:
        member = active_members.get(npub)

        if member is None:
            abort(401, "Member not found")

    else:
        abort(401, "Verification failed")

    #session_key = request.get_cookie('session')
    #if validate_session(npub, session_key) is False:
    #    abort(401, "Session Invalid")

    #logo = request.files.get('logo')
    #print('logo', logo)
    events = []

    for key in request.files.keys():
        files = request.files.getall(key)

        for file in files:
            events.append(newFileEvent(npub, member.get('name'), file))

    return json.dumps(events)


# This handles all the static files in the given system...
# Until we get NGINX to take care of it.
@app.route('/static/<filepath:path>')
def static(filepath):
        return static_file(filepath, root=f'{os.path.dirname(os.path.realpath(__file__))}/static')

@app.route('/u/<filepath:path>')
def static(filepath):
        return static_file(filepath, root=f'{os.getcwd()}/data/u')

@app.route('/account')
def admin_page():
    member = member_from_cookie()
    if member is None:
        return redirect(path)

    spots = get_spot_data(owner=member.get('name'), disabled=True)
    if len(spots) > 0:
        coords = spots[0].get('latLng')
        coords = [float(coords[0]), float(coords[1])]
    else:
        coords = [20.87, -105.44]

    trees = ip_tracker()
    return template('greenspots/account.tpl', coords=coords, member=member, spots=spots, trees=trees, static_path=static_path)


### Admin Section
@app.route('/admin')
def admin_page():
    member = member_from_cookie()
    coords = [20.87, -105.44]
    if member is None:
        return redirect(path)
    
    if "admin" not in member.get('realms'):
        return redirect(path)

    spots = get_spot_data(disabled=True)
    trees = ip_tracker()
    return template('greenspots/admin.tpl', coords=coords, member=member, spots=spots, trees=trees, static_path=static_path)

@app.route("/spot/<filename>", ['POST','UPDATE','GET','DELETE'])
def spot(filename = None):
    if filename is None:
        return "I need a filename"

    try:
        filepath = f'data/spots/{filename}'
        if (request.method != 'POST'):
            spot_file = dict(files.load(filepath))
    except FileNotFoundError:
        return "nah b, that's not a file. get real"

    if request.method == 'GET':
        return spot_file

    if request.method == 'POST':
        response_dict = request.json
        files.make_file(response_dict, "file info", filepath)
        return dict(files.load(filepath))

    if request.method == 'UPDATE':
        response_dict = request.json
        updates = {}
        for entry in response_dict:
            if not response_dict.get(entry) == spot_file.get(entry):
                print("updated: ", spot_file.get(entry), "to", response_dict.get(entry))
                updates[entry] = response_dict.get(entry)

        files.update_file(updates, filepath)
        return dict(files.load(filepath))

    if request.method == 'DELETE':
        files.delete_file(filepath)
        return spot_file
### Admin Section

@app.route('/')
@app.route('/<route>')
def index(route="index"):
    member = member_from_cookie()
    spots = get_spot_data()
    trees = ip_tracker()

    # This needs to be specified further, eventually. This is the coordinate for Sayulita, MX
    coords = [20.87, -105.44]

    return template(f'greenspots/{route}.tpl', **defaults())

if __name__ == "__main__":
    app.run(host='localhost', port=1620, debug=True)

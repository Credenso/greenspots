from ingredients.bottle import Bottle, route, run, template, static_file, TEMPLATE_PATH, request, response, redirect
from ingredients import files, schnorr, members
from datetime import date
import json
import os

app = Bottle()
path = '/greenspots/' # How to get to this module from the root
name = "Greenspots"
description = "Support Sustainability! A map of ecologically conscious local businesses."
image_full = f'{path}static/images/full.png'
image_thumb = f'{path}static/images/thumb.png'
public = True

TEMPLATE_PATH.append(f'potions/greenspots/views')

# This may need to be configured
static_path = '/static/'

os.makedirs('data/members', exist_ok=True)
os.makedirs('data/spots', exist_ok=True)
os.makedirs('data/visitors', exist_ok=True)

active_members = members.MembersList('data/members')

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

# This handles all the static files in the given system...
# Until we get NGINX to take care of it.
@app.route('/static/<filepath:path>')
def static(filepath):
        return static_file(filepath, root=f'{os.path.dirname(os.path.realpath(__file__))}/static')

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

    return template(f'greenspots/{route}.tpl', member=member, spots=json.dumps(spots), trees=trees, coords=coords, static_path=static_path)

if __name__ == "__main__":
    app.run(host='localhost', port=1620, debug=True)

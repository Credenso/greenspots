from ingredients.bottle import Bottle, route, run, template, static_file
import os

app = Bottle()

# This handles all the static files in the given system...
# Until we get NGINX to take care of it.
@app.route('/static/<filepath:path>')
def static(filepath):
        return static_file(filepath, root=f'{os.getcwd()}/static')

@app.route('/<route>')
def index(route):
    return template(f'greenspots/{route}.tpl', star="credenso.cafe")

@app.route('/')
def index():
    return template('greenspots/index.tpl', star="credenso.cafe")

app.run(host='localhost', port=1619, debug=True)

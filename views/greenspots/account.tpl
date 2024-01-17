% rebase('greenspots/index.tpl')

<link rel="stylesheet" href="{{ static_path }}assets/leaflet/leaflet.css" />
<script src="{{ static_path }}assets/leaflet/leaflet.js"></script>

<style>
h1 {
    width: 100%;
    text-align: center;
    color: #4C4;
}

form {
    display: none;
}

.hidden {
    display: none;
}

.logo_upload input {
    width: 100%;
}

form.active {
    display: inline;
}

.container {
    display: flex;
    padding: 1em;
    flex-direction: row;
}

#form_box {
    flex: 2;
    margin: 1em;
}

#form_box input {
    float: right;
}

#map {
    height: 300px;
    padding: 1em;
    margin: 1em;
}

#spot_selector {
    flex: 1;
}

#spot_selector ul {
    padding-left: 0;
    background: #eeeeee;
    border-radius: 0.25em;
    max-height: 30em;
    overflow-y: scroll;
}

#spot_selector li {
    list-style: none;
    padding: 0.25em;
}

#spot_selector li.active {
    background-color: #44cc44;
}

#spot_selector li:hover {
    background-color: #dddddd;
}

#spot_selector li.active:hover {
    background-color: #44bb44;
}
</style>

    <h1>{{ member.get('display_name') or member.get('name') }}'s Spots</h1>
    <div class="container">
        <div id="form_box">
            <div id="map"></div>
            % for spot in spots:
            <form id="form_{{ spot.get('filename') }}">
		<div class="row gtr-uniform">
			<div class="col-12">
				<input type="text" name="name" value="{{ spot.get('name') }}" placeholder="Business Name">
			</div>
			<div class="col-12">
				<select name="type" id="type" value="{{ spot.get('type') }}">
					<option value="">- Type of Spot -</option>
					<option value="hotel">Hotel / Hostel</option>
					<option value="restaurant">Restaurant</option>
					<option value="store">Merchandise</option>
					<option value="service">Services</option>
				</select>
			</div>
			<div class="col-12">
                		<textarea type="text" name="description" placeholder="Description">{{ spot.get('description') }}</textarea>
			</div>
			<div class="col-12">
				<input type="text" name="phone" value="{{ spot.get('phone') }}" placeholder="Phone #">
			</div>
			<div class="col-12">
                		<input type="email" name="email" value="{{ spot.get('email') }}" placeholder="Email Address">
			</div>
			<div class="col-12">
                		<input type="text" name="website" value="{{ spot.get('website') }}" placeholder="Website URL">
			</div>
			<div class="col-6">
                		<label for="lat">Latitude</label>
                		<input type="text" name="lat" value="{{ spot.get('latLng')[0] }}" disabled>
			</div>
			<div class="col-6">
                		<label for="lng">Longitude</label>
                		<input type="text" name="lng" value="{{ spot.get('latLng')[1] }}" disabled>
			</div>
			<div class="col-12">
				% if spot.get('enabled') == "true":
                		<input id="enabled" type="checkbox" style="float: unset" name="enabled" checked>
				% else:
                		<input id="enabled" type="checkbox" style="float: unset" name="enabled">
				% end
				<label for="enabled">Enabled</label>
			</div>
                	<input type="hidden" name="img" value="{{ spot.get('logo') }}" />
			<div class="col-12">
				<ul class="actions">
                			<li><button id="updateLatLng">Update Location</button>
                			<li><button class="primary" id="save">Save</button>
				</ul>
			</div>
		</div>
            </form>
            % end
        </div>
        <div id="spot_selector">
	    <div id="default_logo" class="logo_upload hidden">
            	<h3>Logo</h3>
            	<div class="box">
            	    <img id="logo_img" class="image fit" src="{{ static_path }}spot.svg" />
		    <input id="logo_img_file" type="file" accept="image/*">
            	</div>
	    </div>
	
            <h3>Locations</h3>
            <ul>
                % for spot in spots:
                    <li class="spot" lat="{{ spot.get('latLng')[0] }}" lng="{{ spot.get('latLng')[1] }}" id="{{ spot.get('filename') }}">{{ spot.get('name') }}</li>
                % end
            </ul>
            <button id="add_spot">➕</button>
            <button id="remove_spot">➖</button>
        </div>
    </div>

<script>
// Basic Leaflet Stuff
const initialView = {{ coords }};     
const map = L.map('map').setView(initialView, 15);
L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',                                              
{
    attribution: `&copy;<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap</a>,
    &copy;<a href="https://carto.com/attributions" target="_blank">CARTO</a>`,
    subdomains: 'abcd',
    maxZoom: 20,
}
).addTo(map);

var popup = L.popup();

// spot selecting pin
let active_marker = L.marker()
let latLngSelector = undefined

const onMapClick = (e) => {
    latLngSelector = e.latlng
    popup
    .setLatLng(latLngSelector)
    .setContent('Update Location Here')
    .openOn(map);
}

map.on('click', onMapClick);


const spotSelected = (e) => {
    // select the new spot in the menu
    document.querySelector('li.active')?.classList.remove("active");
    e.target.classList.add('active')

    // first, deselect active spot
    document.querySelector('form.active')?.classList.remove("active");

    // then, show the relevant form
    document.querySelector(`#form_${e.target.id}`).classList.add("active");

    // Make sure the right value from the dropdown is selected
    const selected = document.querySelector('form.active').querySelector('select').getAttribute('value')

    document.querySelector('form.active').querySelector(`option[value='${selected}']`).defaultSelected = true

    // Recenter the map
    const latlng = [e.target.getAttribute('lat'), e.target.getAttribute('lng')]
    active_marker
    .setLatLng(latlng)
    .addTo(map);
    map.flyTo(latlng);

    const img = document.querySelector(`#form_${e.target.id}`).querySelector('input[name="img"]').value

    document.querySelector(`#default_logo`).classList.remove("hidden");
    document.querySelector('#logo_img_file').files = null;
    document.querySelector('#logo_img_file').value = "";

    if (img) {
    	document.querySelector('#logo_img').src = `${img}`;
    } else {
    	document.querySelector('#logo_img').src = `{{ static_path }}spot.svg`;
    }
}

const previewImage = (e) => {
	console.log('Previewing image')
	const file = e.target.files[0]

	if (file !== undefined) {
		const img = document.getElementById('logo_img')
		img.src = URL.createObjectURL(file)
		img.alt = file.name
	}
}

document.querySelector('#logo_img_file').addEventListener('change', previewImage)


// Selecting from the menu
document.querySelectorAll('li.spot').forEach((spot) => {
    spot.addEventListener('click', spotSelected);
})

const updateLatLng = (e) => {
    e.preventDefault()
    if (latLngSelector) {
    console.log('updating')
    form = document.querySelector('form.active')
    form.querySelector('input[name="lat"]').value = latLngSelector.lat
    form.querySelector('input[name="lng"]').value = latLngSelector.lng

    popup.remove()

    active_marker.setLatLng(latLngSelector)

    latLngSelector = undefined

    } else {
    alert("You need to select a spot on the map before updating the location.")
    }
}

document.querySelectorAll('button#updateLatLng').forEach((btn) => {
    btn.addEventListener('click', updateLatLng);
});

const saveDeets = async (e) => {
    e.preventDefault()

    form = document.querySelector('form.active')
    const updates = {
        "name": form["name"].value,
        "type": form["type"].value,
        "description": form["description"].value,
        "phone": form["phone"].value,
        "website": form["website"].value,
        "email": form["email"].value,
        "latLng": [form["lat"].value, form["lng"].value],
        "enabled": (form["enabled"].checked) ? "true" : "false",
        "owner": '{{ member.get('name') }}'
    }

    const img = document.querySelector('#logo_img_file').files[0]
    if (img) {
    	let formData = new FormData();
    	formData.append("logo", img)
    	const res = await fetch('/new_upload', { method: 'post', body: formData })
    	const ev = await res.json()
	const full_path = ev[0].tags.find(t => t[0] === "url")[1]

	// This creates a path that doesn't specify a domain
	updates["logo"] = "/" + full_path.split('/').slice(3).join('/')
    }

    // This value is normally rendered as form_filename
    const filename = form.id.substring(5)

    // PUT if it is a new spot, UPDATE otherwise
    if (filename === "new_spot") {
    	console.log('gonna make a new one!')

        if (updates['name'] === "New Spot") {
            alert('You need to choose a better name than that!')
            return
        }
        const filename_from_name = form["name"].value.toLowerCase().replaceAll(/[^a-zA-Z0-9]/g, '')
        const response = await fetch(`spot/${filename_from_name}`, {
            method: "POST",
            mode: "cors",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(updates)
            });
    } else {

        const response = await fetch(`spot/${filename}`, {
            method: "UPDATE",
            mode: "cors",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(updates)
            });

        console.log(await response.json())
    }
    location.reload()
}

document.querySelectorAll('button#save').forEach((btn) => {
    btn.addEventListener('click', saveDeets);
});

const newSpot = async () => {
    if (document.querySelector("#new_spot")) {
        alert("You're already adding a new spot. Save it before you continue.")
        return 1
    }

    const form = document.createElement('form')
    form.id = "form_new_spot"
    const current_location = map.getCenter()
    form.innerHTML = `
		<div class="row gtr-uniform">
			<div class="col-12">
				<input type="text" name="name" value="" placeholder="Business Name">
			</div>
			<div class="col-12">
				<select name="type" id="type" value="">
					<option value="">- Type of Spot -</option>
					<option value="hotel">Hotel / Hostel</option>
					<option value="restaurant">Restaurant</option>
					<option value="store">Merchandise</option>
					<option value="service">Services</option>
				</select>
			</div>
			<div class="col-12">
                		<input type="text" name="description" value="" placeholder="Description">
			</div>
			<div class="col-12">
				<input type="text" name="phone" value="" placeholder="Phone #">
			</div>
			<div class="col-12">
                		<input type="email" name="email" value="" placeholder="Email Address">
			</div>
			<div class="col-12">
                		<input type="text" name="website" value="" placeholder="Website URL">
			</div>
			<div class="col-6">
                		<label for="lat">Latitude</label>
                		<input type="text" name="lat" value="${current_location.lat}" disabled>
			</div>
			<div class="col-6">
                		<label for="lng">Longitude</label>
                		<input type="text" name="lng" value="${current_location.lng}" disabled>
			</div>
			<div class="col-12">
                		<input id="enabled" type="checkbox" style="float: unset" name="enabled">
				<label for="enabled">Enabled</label>
			</div>
                	<input type="hidden" name="img" value="" />
			<div class="col-12">
				<ul class="actions">
                			<li><button id="updateLatLng">Update Location</button>
                			<li><button class="primary" id="save">Save</button>
				</ul>
			</div>
		</div>`

    form.querySelector('button#save').addEventListener('click', saveDeets);
    form.querySelector('button#updateLatLng').addEventListener('click', updateLatLng);

    const li = document.createElement('li');
    li.innerHTML = "New Spot"
    li.id = "new_spot"
    li.setAttribute('lat', current_location.lat)
    li.setAttribute('lng', current_location.lng)
    li.addEventListener('click', spotSelected);

    const spot_selector = document.querySelector('div#spot_selector ul')
    spot_selector.append(li)
    spot_selector.scrollTop = spot_selector.scrollHeight
    document.querySelector('div#form_box').append(form)
    form.classList.add('active')
    li.click()
}

document.querySelector('button#add_spot').addEventListener('click', newSpot);

const deleteSpot = async () => {
    spotToDelete = document.querySelector('li.active')
    filename = spotToDelete.id
    if (confirm(`Are you sure you want to delete ${spotToDelete.innerHTML}?`)) {
        const response = await fetch(`spot/${filename}`, {
            method: "DELETE",
            mode: "cors",
            headers: {
                "Content-Type": "application/json"
            },
            body: {
                "file": filename
                }
            });

        location.reload()
        console.log(await response.json())
    }
}
document.querySelector('button#remove_spot').addEventListener('click', deleteSpot);
</script>

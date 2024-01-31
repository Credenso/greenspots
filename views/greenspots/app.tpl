% rebase('greenspots/index.tpl')
% setdefault('coords', None)
% setdefault('lang', 'es')

<link rel="stylesheet" href="{{ static_path }}assets/leaflet/leaflet.css" />
<style>
	#map {
		height: 40em;
		width: 100%;
		border-radius: 0.5em;
		box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
	}

	.app {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		margin: 2em auto;
		width: 80vw;
		max-width: 33em;
	}

	.logo {
		width: 100%;
		max-width: 20em;
	}

	.slogan {
		font-size: 1.5em;
	}

	.popup {
		width: inherit;
		min-width: 15em;
		max-height: 30em;
		overflow-y: scroll;
		scrollbar-width: none;
	}

	.popup::-webkit-scrollbar {
		display: none;
	}

	.flex-column {
		display: flex;
		flex-direction: column;
		align-items: left;
		justify-content: space-between;
	}

	.full {
		position: absolute !important;
		top: 0 !important;
		left: 0 !important;
		height: 100% !important;
		width: 100vw !important;
	}

</style>

<div class="app">
<img class="logo" src="{{ static_path }}images/greenspots.png" />
% if lang == "es":
<p class="slogan">Apoya al Medioambiente</p>
% else:
<p class="slogan">Support Sustainability</p>
% end
<section id="map">
<a class="icon solid fa-expand"  style="position: absolute; font-size: 2em; cursor: pointer; top: 0.25em; right: 0.5em; z-index: 1000" onclick="full()"></a>
<a class="icon solid fa-location"  style="position: absolute; font-size: 2em; cursor: pointer; bottom: 0.25em; left: 0.5em; z-index: 1000" onclick="locate()"></a>
<a class="icon solid fa-home"  style="position: absolute; font-size: 2em; cursor: pointer; bottom: 0.25em; left: 2.5em; z-index: 1000" onclick="recenter()"></a>
</section>
</div>

<script src="{{ static_path }}assets/leaflet/leaflet.js"></script>

<script>
let myLocation = undefined

// Set up the Leaflet map
let map = L.map('map').setView({{ coords or "[51.505, -0.09]" }}, 15);
L.tileLayer('https://d.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="https://carto.com/attribution/">CARTO</a>'
}).addTo(map);

let spotMarker = L.icon({
	iconUrl: '{{ static_path }}spot.svg',
	iconSize: [40,40],
	iconAnchor: [20,40]
})

let redSpotMarker = L.icon({
	iconUrl: '{{ static_path }}red_spot.svg',
	iconSize: [40,40],
	iconAnchor: [20,40]
})

// Get the spots from Bottle's templating engine
const spots = {{ !spots }}

const describeSpotType = (type) => {
	switch(type) {
		case "hotel":
			return "Hotel / Hostel";
		case "restaurant":
			return "Restaurant";
		case "service":
			return "Service";
		default:
			return "Greenspot";
	}
}

spots.forEach(spot => {
	const popup = document.createElement('div')
	popup.classList.add('popup')
	popup.innerHTML = `
	<div class="flex-column">
	<h3 style="margin-bottom: 0">${spot.name}</h3>
	<h5 style="margin-bottom: 0">${describeSpotType(spot.type)}</h5>
	<ul id="badges" class="icons" style="margin-bottom: 0">
	</ul>
	<img style="width: 100%; max-width: 15em; margin: auto; border-radius: 0.5em" src="${spot.logo || '{{ static_path }}spot.svg' }" />
	<p>${spot.description}</p>
	<ul id="contact" class="actions small" style="margin-bottom: 0">
	</ul>
	</div>
	`
	const badges = popup.querySelector('#badges')
	spot.badges?.forEach(badge => {
		`<li><a href="#" class="icon solid fa-dove"></a></li>`
		switch(badge) {
			case "supporter":
				badges.innerHTML += `<li><a href="#" class="icon solid fa-dove"></a></li>`
				break;
			case "composter":
				badges.innerHTML += `<li><a href="#" class="icon solid fa-seedling"></a></li>`
				break;
			case "recycler":
				badges.innerHTML += `<li><a href="#" class="icon solid fa-recycle"></a></li>`
				break;
			case "renewer":
				badges.innerHTML += `<li><a href="#" class="icon solid fa-leaf"></a></li>`
				break;
		}
	})
		


	const contact = popup.querySelector('#contact')

	if (spot.phone) {
		contact.innerHTML += `<li><a href="tel:${spot.phone}" class="button small icon solid fa-phone">Phone</a></li>`
	}

	if (spot.email) {
		contact.innerHTML += `<li><a href="mailto:${spot.email}" class="button small icon solid fa-envelope">Email</a></li>`
	}

	if (spot.website) {
		contact.innerHTML += `<li><a href="${spot.website}" target="_blank" class="button small icon solid fa-globe">Site</a></li>`
	}

	if (spot.review) {
		contact.innerHTML += `<li><a href="${spot.review}" class="button small icon solid fa-star">Review</a></li>`
	}
	
	L.marker(spot.latLng, {icon: spotMarker})
	.bindPopup(popup, {
		maxWidth: "auto"
	})
	.addTo(map)
})

// Toggle fullscreen map
const full = () => {
	window.scrollTo(0,0)
	const m = document.querySelector('#map');
	m.classList.toggle('full')
	map.invalidateSize()
}

map.addEventListener('locationfound', (e) => {
	myLocation = L.marker(e.latlng, {icon: redSpotMarker})
	myLocation.addTo(map)
	map.flyTo(e.latlng, 18)
	//map.flyTo(e.latlng, 18, { duration: 2 })
})

const locate = () => {
	if (myLocation) myLocation.remove()
	map.locate({ enableHighAccuracy: true })
}

const recenter = () => {
	map.setView({{ coords or "[51.505, -0.09]" }}, 15);
}
	
console.log(spots)
</script>



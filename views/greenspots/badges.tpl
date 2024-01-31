% rebase('greenspots/index.tpl')
% setdefault('static_path', '/static/')
% setdefault('lang', 'es')

<section class="main">
	<header class="invert accent2">
		% if lang == 'es':
		<h1>Insignias</h1>
		<p>Greenspots mantiene el listón muy alto en sus metas de sostentibilidad.</p>
		% else:
		<h1>Badges</h1>
		<p> Greenspots holds the bar high when it comes to reaching sustainability goals.</p>
		% end
	</header>
	<span class="image main filtered"><img src="{{ static_path }}images/stairwell.jpg" alt="" /></span>
	% if lang == 'es':
	<p>En el mundo de la sostenibilidad y la administración, siempre se puede hacer más. Greenspots establece un sistema de "insignias" para que cada empresa pueda mostrar lo que está haciendo para apoyar la sostenibilidad a su manera.	</p>
	<p>
		<i>Se necesita al menos una insignia para aparecer en el mapa.</i>
	</p>

	<div class="anchor" id="reducer">
	<h3><span class="icon solid fa-seedling" style="margin-right: 1em"></span> Reductor</h3>
	<p>Los <b>reductores</b> están a la vanguardia de la lucha por la sostenibilidad. Al elegir vender u ofrecer materiales compostables o reutilizables, mantienen baja la demanda de materiales de desecho.</p>

	<div class="anchor" id="reuser">
	<h3><span class="icon solid fa-leaf" style="margin-right: 1em"></span> Reutilizador</h3>
	<p>Los <b>reutilizadors</b> aprovechan al máximo lo que ya está disponible. Al ofrecer servicios que fomentan la reutilización de los recursos existentes (ropa de segunda mano, recarga de botellas de agua), estos negocios permiten a las personas aprovechar al máximo lo que ya tienen.</p>

	<div class="anchor" id="recycler">
	<h3><span class="icon solid fa-recycle" style="margin-right: 1em"></span> Reciclador</h3>
	<p>Los <b>recicladors</b> están clasificando sus desechos, asegurándose de separar sus productos reciclables y compostables.</p>
	% else:

	<p>
		In the world of sustainability and stewardship, there's always more that can be done. 
		Greenspots establishes a 'badge' system so each business can show what they're doing
		to support sustainability in their own way. 
	</p>
	<p>
		<i>At least one badge is needed to show up on the map.</i>
	</p>

	<div class="anchor" id="reducer">
	<h3><span class="icon solid fa-seedling" style="margin-right: 1em"></span> Reducer</h3>
	<p><b>Reducers</b> are at the forefront of the fight for sustainability. By choosing to sell or offer compostable or reusable materials, they keep the demand for wasteful materials down.</p>

	<div class="anchor" id="reuser">
	<h3><span class="icon solid fa-leaf" style="margin-right: 1em"></span> Reuser</h3>
	<p><b>Reusers</b> make the most of what's already available. By offering services that encourage the reuse of existing resources (second-hand clothes, refilling water bottles), these businesses enable people to make the most of what they already have.</p>

	<div class="anchor" id="recycler">
	<h3><span class="icon solid fa-recycle" style="margin-right: 1em"></span> Recycler</h3>
	<p><b>Recyclers</b> are sorting their stuff out, making sure that they're relying on the appropriate facilities and services to take care of their recyclable and compostable goods. 
</p>
	% end
	<!--<h3><span class="icon solid fa-trash" style="margin-right: 1em"></span> Zero Waste</h3>
	<p><b>Zero Waste</b> businesses are setting an example by refusing refuse. A spot with this badge is committed to diverting all waste away from the landfill and towards recycling or composting initiatives.</p>
	<h3><span class="icon solid fa-heart" style="margin-right: 1em"></span> Living Wage</h3>
	<p><b>Living Wage</b> spots focus on the human aspects of sustainability, making sure that all employees earn enough for themselves and their families to live in relative comfort.</p>
	<h3><span class="icon solid fa-location-arrow" style="margin-right: 1em"></span> Local-First</h3>
	<p><b>Local-First</b> businesses are committed to supporting the local economy, sourcing all regular purchases from businesses in a range of 100 kilometres.</p>-->
</section>

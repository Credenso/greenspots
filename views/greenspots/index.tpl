<!DOCTYPE HTML>
<!--
	Transit by Pixelarity
	pixelarity.com | hello@pixelarity.com
	License: pixelarity.com/license
-->

% setdefault('star', 'greenspots.net')
% setdefault('lang', 'es')
<html>
	<head>
		<title>Greenspots</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="{{ static_path }}assets/css/main.css" />
		<link rel="icon" href="{{ static_path }}spot.svg" />
		<style>
			.links {
				font-size: 1.4em;
			}

			.features a {
				border-bottom: none;
			}

			.lang a {
				border-bottom: none;
				font-size: 1.5em;
				margin-right: 0.5em;
			}
		
			.flex {
				display: flex;
				flex-direction: row;
			}
		</style>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="flex">
							<div class="lang">
								% if lang == "en":
								<a href="/lang/es">🇨🇦</a>
								% elif lang == "es":
								<a href="/lang/en">🇲🇽</a>
								% end
							</div>
							<a href="/" class="logo"><strong>greenspots</strong>@{{ star }}</a>
						</div>
						<nav>
							<a href="#menu">Menu</a>
						</nav>
					</header>

				<!-- Nav -->
					% if lang == "es":
					<nav id="menu">
						<ul class="links">
							<li><a href="index">Página Principal</a></li>
							<li><a href="app">Aplicación</a></li>
							<li><a href="badges">Insignias</a></li>
							<!--<li><a href="features">Features</a></li>-->
						</ul>
						<ul class="actions stacked">
							% if member:
							% if "admin" in member.get('realms'):
							<li><a href="admin" class="button primary fit">Panel de administración</a></li>
							% else:
							<li><a href="account" class="button primary fit">Mi Cuenta</a></li>
							% end
							<li><a href="/logout" class="button fit">Cerrar sesión para {{ member.get('display_name') or member.get('name') }}</a></li>

							% else:
							<li><a href="#" class="button primary fit">Únete</a></li>
							<li><a href="/login" class="button fit">Inicia sesión</a></li>
							% end
						</ul>
					</nav>
					% else:
					<nav id="menu">
						<ul class="links">
							<li><a href="index">Home</a></li>
							<li><a href="app">App</a></li>
							<li><a href="badges">Badges</a></li>
							<!--<li><a href="features">Features</a></li>-->
						</ul>
						<ul class="actions stacked">
							% if member:
							% if "admin" in member.get('realms'):
							<li><a href="admin" class="button primary fit">Admin Panel</a></li>
							% else:
							<li><a href="account" class="button primary fit">My Account</a></li>
							% end
							<li><a href="/logout" class="button fit">Log Out {{ member.get('display_name') or member.get('name') }}</a></li>

							% else:
							<li><a href="#" class="button primary fit">Sign Up</a></li>
							<li><a href="/login" class="button fit">Log In</a></li>
							% end
						</ul>
					</nav>
					% end 

				% if defined('base'):
					{{ !base }}
				% else:
					<!-- Banner -->
						<section id="banner">
							<div class="image filtered" data-position="center">
								<img src="{{ static_path }}images/bridge.jpg" alt="" />
							</div>
							<div class="content">
								<img src="{{ static_path }}images/greenspots.png" alt="" style="width: 100%; max-width: 15em; drop-shadow: 1em 1em"/>
								% if lang == "es":
								<h1>Apoya al Medioambiente</h1>
								<p><b>Greenspots</b> es un mapa de empresas locales que se preocupan por su impacto ambiental.</p>
								<ul class="actions special">
									<li><a href="app" class="button wide scrolly">Mira el mapa</a></li>
								</ul>
								% else:
								<h1>Support Sustainability</h1>
								<p><b>Greenspots</b> is a map of local businesses with practices that consider their global impact as a first priority.</p>
								<ul class="actions special">
									<li><a href="app" class="button wide scrolly">Check the app</a></li>
								</ul>
								% end
							</div>
						</section>

					<!-- Section -->
						<section id="first" class="main special">
							% if lang == "es":
							<h2>Formas diferentes para participar</h2>
							<p>Greenspots promove cualquier negocio que haga cualquiera de los siguientes puntos:</p>

							<!-- Note: If you have an odd number of icons, change the class below to "features odd" -->
							<ul class="features odd">
								<li><a href="badges#reducer">
									<span class="icon major solid fa-seedling"></span>
									<h3>Reductor</h3>
								</a></li>
								<li><a href="badges#reuser">
									<span class="icon major solid fa-leaf"></span>
									<h3>Reutilizador</h3>
								</a></li>
								<li><a href="badges#recycler">
									<span class="icon major solid fa-recycle"></span>
									<h3>Reciclador</h3>
								</a></li>
								<!--<li><a href="badges#supporter">
									<span class="icon major solid fa-dove"></span>
									<h3>Renovador</h3>
								</a></li>-->
							</ul>
							% else:
							<h2>Different Ways to Play</h2>
							<p>Greenspots promotes any businesses which uphold one or more of the standards we set out to maintain:</p>

							<!-- Note: If you have an odd number of icons, change the class below to "features odd" -->
							<ul class="features odd">
								<li><a href="badges#reducer">
									<span class="icon major solid fa-seedling"></span>
									<h3>Reducer</h3>
								</a></li>
								<li><a href="badges#reuser">
									<span class="icon major solid fa-leaf"></span>
									<h3>Reuser</h3>
								</a></li>
								<li><a href="badges#recycler">
									<span class="icon major solid fa-recycle"></span>
									<h3>Recycler</h3>
								</a></li>
								<!--<li><a href="badges#supporter">
									<span class="icon major solid fa-dove"></span>
									<h3>Supporter</h3>
								</a></li>-->
							</ul>
							% end
						</section>

					<!-- Spotlight -->
						<section class="main spotlight left invert accent1">
							<div class="image" data-position="center">
								<img src="{{ static_path }}images/sprout_hands.jpg" alt="" />
								<!--Photo by <a href="https://unsplash.com/@danteov_seen?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Nikola Jovanovic</a> on <a href="https://unsplash.com/photos/woman-holding-green-leafed-seedling-OBok3F8buKY?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>-->
							</div>
							<div class="content">
								% if lang == "es":
								<h2>Nuestros Normas</h2>
								<p>Tenemos normas distinctas para saber en que formas los negocios estan practicando la sustentabilidad, y las formas en que ellos todavia pueden crescer.</p> 
								<ul class="actions">
									<li><a href="badges" class="button">Aprende más</a></li>
								</ul>
								% else:
								<h2>Our Standards</h2>
								<p>
									Greenspots relies on a variety of distinct
									standards to determine where companies are
									meeting the mark and where they have room
									to grow.
								</p> 
								<ul class="actions">
									<li><a href="badges" class="button">Learn More</a></li>
								</ul>
								% end
							</div>
						</section>

					<!-- Section -->
						<!--<section class="main special">
							<h2>Featured Companies</h2>
							<p>Read more about what some local businesses are doing to go above and beyond our call-to-action.</p>
							<div class="slider-wrapper">
								<div class="slider">
									<article class="initial">
										<a href="#" class="image">
											<img src="{{ static_path }}images/laselva.jpg" alt="" />
										</a>
										<div class="content">
											<p>Bienvenidos a La Selva!</p>
										</div>
									</article>
									<article>
										<a href="#" class="image">
											<img src="{{ static_path }}images/heavens_kitchen.jpg" alt="" />
										</a>
										<div class="content">
											<p>Portal Del Rio welcomes you!</p>
										</div>
									</article>
								</div>
							</div>
						</section>-->

					<!-- Section -->
						<!--<section class="main special invert accent3">
							<h2>Request a Meeting</h2>
							<p>If you would like your business to be listed on Greenspots or request our services, feel free to sign up for a welcome package.</p>
							<form method="post" action="#" class="combined">
								<input type="email" name="email" value="" placeholder="Your email address" />
								<button type="submit" class="primary">Learn More</button>
							</form>
						</section>-->

					<!-- Section -->
						<section class="main special">
							% if lang == "es":
							<h2>Mantener Contacto</h2>
							<p>Para mas informacion, nos estamos disponibles en:</p>
							% else:
							<h2>Get in touch</h2>
							<p>For any further inquiries, we can be reached at:</p>
							% end
							<ul class="contact-icons">
								<li><a href="mailto:greenspots@credenso.cafe">
									<span class="icon major alt fa-envelope"></span>
									<p>greenspots@credenso.cafe</p>
								</a></li>
								<li><a href="https://maps.app.goo.gl/6e4mwQToaU2TqhFk7">
									<span class="icon major alt fa-map"></span>
									<p>El Refugio de Sayulita</br>
									C. Manuel M. Plascencia 18, </br>
									La Estropajera, 63734</br>
									Sayulita, Nay.</p>
								</a></li>
								<li><a href="https://wa.me/+523221188127">
									<span class="icon major alt brands fa-whatsapp"></span>
									<p>+52 322 118 8127</p>
								</a></li>
							</ul>
						</section>
				% end

				<!-- Footer -->
					<footer id="footer">
						<p class="copyright"><a href="https://credenso.cafe/">&copy;redenso</a></p>
						<ul class="icons">
							<li><a href="#" class="icon brands fa-github"><span class="label">GitHub</span></a></li>
						</ul>
					</footer>

			</div>
			% include('greenspots/components/forest.tpl', trees=trees)

		<!-- Scripts -->
			<script src="{{ static_path }}assets/js/jquery.min.js"></script>
			<script src="{{ static_path }}assets/js/jquery.scrolly.min.js"></script>
			<script src="{{ static_path }}assets/js/browser.min.js"></script>
			<script src="{{ static_path }}assets/js/breakpoints.min.js"></script>
			<script src="{{ static_path }}assets/js/util.js"></script>
			<script src="{{ static_path }}assets/js/main.js"></script>
			<script>
				const logout = () => {
					document.cookie = "npub=; expires=-1;path=/";
					document.cookie = "nsec=; expires=-1;path=/";
					window.location.reload()
				}
			</script>
	</body>
</html>

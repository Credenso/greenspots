<!DOCTYPE HTML>
<!--
	Transit by Pixelarity
	pixelarity.com | hello@pixelarity.com
	License: pixelarity.com/license
-->

% setdefault('star', 'credenso.cafe')
<html>
	<head>
		<title>Greenspots</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="{{ static_path }}assets/css/main.css" />
		<link rel="icon" href="{{ static_path }}spot.svg" />
		<style>
			#sun {
				position: absolute;
				top: 0;
				left: 0;
				width: 4em;
				cursor: pointer;
				display: none;
			}

			.links {
				font-size: 1.4em;
			}
		</style>
	</head>
	<body class="is-preload">
		<img id="sun" onclick="window.location = '/'" src="/static/images/solar_icon.png" alt="solar" />

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<a href="/greenspots/" class="logo"><strong>greenspots</strong>@{{ star }}</a>
						<nav>
							<a href="#menu">Menu</a>
						</nav>
					</header>

				<!-- Nav -->
					<nav id="menu">
						<ul class="links">
							<li><a href="index">Home</a></li>
							<li><a href="app">App</a></li>
							<li><a href="badges">Badges</a></li>
							<li><a href="features">Features</a></li>
							<li><a href="/">Solar</a></li>
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
								<h1>Support Sustainability</h1>
								<p><b>Greenspots</b> is a map of local businesses with practices that consider their global impact as a first priority.</p>
								<ul class="actions special">
									<li><a href="app" class="button wide scrolly">Check the app</a></li>
								</ul>
							</div>
						</section>

					<!-- Section -->
						<section id="first" class="main special">
							<h2>Different Ways to Play</h2>
							<p>Greenspots promotes any businesses which uphold one or more of the standards we set out to maintain:</p>

							<!-- Note: If you have an odd number of icons, change the class below to "features odd" -->
							<ul class="features">
								<li>
									<span class="icon major solid fa-seedling"></span>
									<h3>Composter</h3>
								</li>
								<li>
									<span class="icon major solid fa-recycle"></span>
									<h3>Recycler</h3>
								</li>
								<li>
									<span class="icon major solid fa-dove"></span>
									<h3>Supporter</h3>
								</li>
								<li>
									<span class="icon major solid fa-leaf"></span>
									<h3>Renewer</h3>
								</li>
							</ul>
						</section>

					<!-- Spotlight -->
						<section class="main spotlight left invert accent1">
							<div class="image" data-position="center">
								<img src="{{ static_path }}images/sprout_hands.jpg" alt="" />
								Photo by <a href="https://unsplash.com/@danteov_seen?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Nikola Jovanovic</a> on <a href="https://unsplash.com/photos/woman-holding-green-leafed-seedling-OBok3F8buKY?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
							</div>
							<div class="content">
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
							</div>
						</section>

					<!-- Section -->
						<section class="main special">
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
						</section>

					<!-- Section -->
						<section class="main special invert accent3">
							<h2>Request a Meeting</h2>
							<p>If you would like your business to be listed on Greenspots or request our services, feel free to sign up for a welcome package.</p>
							<form method="post" action="#" class="combined">
								<input type="email" name="email" value="" placeholder="Your email address" />
								<button type="submit" class="primary">Learn More</button>
							</form>
						</section>

					<!-- Section -->
						<section class="main special">
							<h2>Get in touch</h2>
							<p>For any further inquiries, we can be reached at:</p>
							<ul class="contact-icons">
								<li>
									<span class="icon major alt fa-envelope"></span>
									<p><a href="mailto:greenspots@credenso.cafe">greenspots@credenso.cafe</a></p>
								</li>
								<li>
									<span class="icon major alt fa-map"></span>
									<p>68 Hillsboro Drive <br/>
									Cambridge, ON</p>
								</li>
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
					// Not really sure why both of these are needed
					document.cookie = "npub=; expires=-1;path=/";
					document.cookie = "nsec=; expires=-1;path=/";
					window.location.reload()
				}
			</script>
	</body>
</html>

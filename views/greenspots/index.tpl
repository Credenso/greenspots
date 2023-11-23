<!DOCTYPE HTML>
<!--
	Transit by Pixelarity
	pixelarity.com | hello@pixelarity.com
	License: pixelarity.com/license
-->

% setdefault('star', 'credenso.cafe')
% setdefault('static', '/static/')
<html>
	<head>
		<title>Greenspots</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="{{ static }}assets/css/main.css" />
		<link rel="icon" href="{{ static }}images/favicon.png" />
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<a href="/" class="logo"><strong>greenspots</strong>@{{ star }}</a>
						<nav>
							<a href="#menu">Menu</a>
						</nav>
					</header>

				<!-- Nav -->
					<nav id="menu">
						<ul class="links">
							<li><a href="index">Home</a></li>
							<li><a href="generic">Generic</a></li>
							<li><a href="elements">Elements</a></li>
						</ul>
						<ul class="actions stacked">
							<li><a href="#" class="button primary fit">Sign Up</a></li>
							<li><a href="#" class="button fit">Log In</a></li>
						</ul>
					</nav>

				% if defined('base'):
					{{ !base }}
				% else:
					<!-- Banner -->
						<section id="banner">
							<div class="image filtered" data-position="center">
								<img src="{{ static }}images/bridge.jpg" alt="" />
							</div>
							<div class="content">
								<h1>Support Sustainability</h1>
								<p><b>Greenspots</b> is a map of local businesses with practices that consider their impact on the natural world as a first priority.</p>
								<ul class="actions special">
									<li><a href="http://zenen.space/greenspots" class="button wide scrolly">Check the app</a></li>
								</ul>
							</div>
						</section>

					<!-- Section -->
						<section id="first" class="main special">
							<h2>Different Ways to Play</h2>
							<p>Greenspots promotes any business upholding one or more of the standards we set out to maintain:</p>

							<!-- Note: If you have an odd number of icons, change the class below to "features odd" -->
							<ul class="features">
								<li>
									<span class="icon major solid fa-seedling"></span>
									<h3>Composted Waste</h3>
								</li>
								<li>
									<span class="icon major solid fa-recycle"></span>
									<h3>Recycling Program</h3>
								</li>
								<li>
									<span class="icon major solid fa-dove"></span>
									<h3>Locally Sourced</h3>
								</li>
								<li>
									<span class="icon major solid fa-leaf"></span>
									<h3>Refurbished Goods</h3>
								</li>
							</ul>
						</section>

					<!-- Spotlight -->
						<section class="main spotlight left invert accent1">
							<div class="image" data-position="center">
								<img src="{{ static }}images/sprout_hands.jpg" alt="" />
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
									<li><a href="standards" class="button">Learn More</a></li>
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
											<img src="{{ static }}images/laselva.jpg" alt="" />
										</a>
										<div class="content">
											<p>Bienvenidos a La Selva!</p>
										</div>
									</article>
									<article>
										<a href="#" class="image">
											<img src="{{ static }}images/heavens_kitchen.jpg" alt="" />
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
								<button type="submit" class="primary">Sign Up</button>
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
								<li>
									<span class="icon solid major alt fa-mobile-alt"></span>
									<p><a href="tel:+12265773840">+1 (226) 577-3840</a></p>
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

		<!-- Scripts -->
			<script src="{{ static }}assets/js/jquery.min.js"></script>
			<script src="{{ static }}assets/js/jquery.scrolly.min.js"></script>
			<script src="{{ static }}assets/js/browser.min.js"></script>
			<script src="{{ static }}assets/js/breakpoints.min.js"></script>
			<script src="{{ static }}assets/js/util.js"></script>
			<script src="{{ static }}assets/js/main.js"></script>

	</body>
</html>

% rebase('greenspots/index.tpl')
% setdefault('static_path', '/static/')
% setdefault('error', None)
% setdefault('redir', None)

<style>
 	#main {
		width: 30em;
		max-width: 100vw;
	}

	h1 {
		text-align: center;
	}
	
	#info, #registration {
		text-align: left;
	}

	.hidden {
		display: none;
	}

	#bad_name {
		font-size: 0.7em;
		color: red;
	}

	.invalid {
		border: 2px solid red !important;
	}
</style>


% if error:
	<div class="error box"> {{ error }} </div>
	<hr>
% end

<div id="registration" class="box">
	<h2>Registration</h2>
	<p>When you first make your account, <b>your password will be the same as your username</b>. To update your information: visit The Bus, open the side menu, and click on My Account - you might need to log in first.</p>
	
	<form method="POST">
		<label for="name">Account Name:</label>
		<input type="text" id="name" name="name" placeholder="your account identifier" required />
		<small id="bad_name" class="hidden">Name already taken</small>
		<br/>
		<label for="email">Email:</label>
		<input type="text" id="email" name="email" placeholder="optional, but helpful" />
		<br/>
		<details>
		<summary>Advanced</summary>
		<label for="nsec">Nostr Private Key:</label>
		<input type="text" id="nsec" name="nsec" placeholder="optional, but helpful" />
		</details>
		<br/>
		<button id="register">Register</button>
	</form>
</div>

<style>
	.error {
		background-color: #FFDDDD;
		margin: 1em;
		border-radius: 0.25em;
		padding: 0.5em;
	}

	#thumbnails {
		display: none;
	}
</style>

<script>
	let existing_accounts = {}

	fetch('/.well-known/nostr.json').then(res => res.json().then(accounts => existing_accounts = accounts))

	const cont = () => {
		document.querySelector('#info').classList.add('hidden')
		document.querySelector('#registration').classList.remove('hidden')
	}

	const validate_name = () => {
		const name = document.querySelector('#name').value.toLowerCase().replace(/[^a-z0-9._]/, "")
		document.querySelector('#name').value = name

		console.log('name', name)
		const existing = existing_accounts.names[name] !== undefined

		if (existing) {
			document.querySelector('#name').classList.add('invalid')
			document.querySelector('#bad_name').classList.remove('hidden')
			document.querySelector('#register').disabled = true
		} else {
			document.querySelector('#name').classList.remove('invalid')
			document.querySelector('#bad_name').classList.add('hidden')
			document.querySelector('#register').disabled = false
		}
	}

	document.querySelector('#continue').checked = false
	document.querySelector('#continue').addEventListener('change', cont)

	document.querySelector('#name').addEventListener('input', validate_name)
</script>

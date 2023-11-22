<!DOCTYPE html>
% setdefault('title', 'No Title Given')
<html>
    <head>
        <title>{{ title }}</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
        <link rel="stylesheet" href="/static/main.css" />
    </head>
    <body>
        <h1>Welcome To Bottle!</h1>
        <a href="/" ><img src="/static/bottle.svg" alt="Bottle Logo"/></a>
        % if defined('base'):
            {{ !base }}
        % else:
            <p>This is only an example template page! It's meant to be used with rebase().</p>
        % end
    </body>
</html>


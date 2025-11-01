# Spotify Slack preview

1. Create a Slack app at https://api.slack.com/apps
2. Copy `.env.dist` to `.env` and set the values.
    - For the _bot token_ go to "Oauth & permissions" and add the `channels:history` and `chat:write` scopes.
    - For the _app token_ go to "Socket Mode" and enable it with `connections:write`.
    - Then click on "Event Subscriptions" and enable events.
    - Click on "Subscribe to bot events" > "Add Bot User Event" and add `message.channels`.
    - Lastly, go to "Install App" and click on the install button.
3. Set up uv and install dependencies: `uv sync --locked`
4. Run the Slackbot: `uv run slack.py`
import os
import re

from dotenv import load_dotenv
from slack_bolt import App
from slack_bolt.adapter.socket_mode import SocketModeHandler

from spotify import get_spotify_track, Track

load_dotenv()

app = App(
    token=os.environ.get("SLACK_BOT_TOKEN"),
)

SPOTIFY_REGEX = r"<(https:\/\/open\.spotify\.com\/\S+)>"


@app.event("message")
def handle_message_events(body, say):
    event = body.get("event", {})
    text = event.get("text", "")

    matches = re.search(SPOTIFY_REGEX, text)
    if matches:
        url = matches.group(1)
        track = get_spotify_track(url)
        say(text=f"{track.title} - {track.artist}", blocks=track_to_slack_blocks(track))


def track_to_slack_blocks(track: Track) -> list[dict]:
    return [
        {
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": f"*{track.title}*\n{track.artist}"
            },
            "accessory": {
                "type": "image",
                "image_url": track.cover,
                "alt_text": "Album cover"
            }
        }
    ]


if __name__ == "__main__":
    SocketModeHandler(app, os.environ["SLACK_APP_TOKEN"]).start()

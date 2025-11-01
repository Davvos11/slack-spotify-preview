import json
import re
from dataclasses import dataclass

import requests


@dataclass
class Track:
    title: str
    artist: str
    cover: str


def get_spotify_track(share_url: str) -> Track:
    r = requests.get("https://open.spotify.com/oembed", params={"url": share_url})
    r.raise_for_status()
    data = r.json()

    # Get title and cover from JSON data (ezpz lemon squeezy)
    title = data.get('title', '')
    cover = data.get('thumbnail_url', '')
    # Get artist name from embed HTML (not ezpz lemon squeezy) :(
    iframe_url = data.get('iframe_url', '')
    artist = get_artist_from_iframe(iframe_url) if iframe_url else ''

    return Track(title, artist, cover)


def get_artist_from_iframe(iframe_url: str) -> str:
    r = requests.get(iframe_url)
    if r.status_code != 200:
        return ''
    # Find the JSON-LD metadata embedded in the page
    regex = re.search(r'<script id="__NEXT_DATA__" type="application/json">(.+?)</script>', r.text)
    if not regex:
        return ''
    data = json.loads(regex.group(1))
    try:
        entity = data['props']['pageProps']['state']['data']['entity']
        match entity['type']:
            case 'track':
                artists = entity['artists']
                return ", ".join(a.get("name", "") for a in artists)
            case 'album':
                return entity.get('subtitle', '')
    except KeyError:
        pass
    return ''


if __name__ == "__main__":
    # (example usage)
    url = "https://open.spotify.com/track/5CMln9nwRTrlCfwXoz7cEK?si=17314a35744f4891"
    print(get_spotify_track(url))

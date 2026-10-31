FROM ghcr.io/astral-sh/uv:python3.13-alpine@sha256:63b8fa4be2338728034164eb6c067a363fdbb3234fa79b64c83545317b7feec1

WORKDIR /code

COPY pyproject.toml uv.lock ./

RUN ["uv", "sync", "--locked"]

COPY . .

CMD ["uv", "run", "slack.py"]
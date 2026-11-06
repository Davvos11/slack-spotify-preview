FROM ghcr.io/astral-sh/uv:python3.13-alpine@sha256:7b02bf9f2d812bf1b21b4d790901eb22250523943b82af93e8c543ea54b6b4d5

WORKDIR /code

COPY pyproject.toml uv.lock ./

RUN ["uv", "sync", "--locked"]

COPY . .

CMD ["uv", "run", "slack.py"]
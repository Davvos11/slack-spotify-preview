FROM ghcr.io/astral-sh/uv:python3.13-alpine

WORKDIR /code

COPY pyproject.toml uv.lock ./

RUN ["uv", "sync", "--locked"]

COPY . .

CMD ["uv", "run", "slack.py"]
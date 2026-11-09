FROM ghcr.io/astral-sh/uv:python3.13-alpine@sha256:7b02bf9f2d812bf1b21b4d790901eb22250523943b82af93e8c543ea54b6b4d5

WORKDIR /code

COPY pyproject.toml uv.lock ./

# uv doesn't use pip, and scanners flag the packages the base image's pip vendors
RUN uv sync --locked && python -m pip uninstall -y pip

COPY . .

CMD ["uv", "run", "slack.py"]

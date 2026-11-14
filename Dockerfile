FROM ghcr.io/astral-sh/uv:python3.13-alpine@sha256:f2d6278d0821c35881b010ddbf75825049661a98dbfdf61bbd1407e8dd544d00

WORKDIR /code

COPY pyproject.toml uv.lock ./

# uv doesn't use pip, and scanners flag the packages the base image's pip vendors
RUN uv sync --locked && python -m pip uninstall -y pip

COPY . .

CMD ["uv", "run", "slack.py"]

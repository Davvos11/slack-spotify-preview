FROM ghcr.io/astral-sh/uv:python3.13-alpine@sha256:f3f098c0532abb45dd01362a6ea3585b8b4cd53f0589be79efb8e529816637ce

WORKDIR /code

COPY pyproject.toml uv.lock ./

# uv doesn't use pip, and scanners flag the packages the base image's pip vendors
RUN uv sync --locked && python -m pip uninstall -y pip

COPY . .

CMD ["uv", "run", "slack.py"]

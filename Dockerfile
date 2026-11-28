FROM ghcr.io/astral-sh/uv:python3.13-alpine@sha256:6e3e7a0061d007bf3d7f1b24c258b62f384ef14fbe2df673493d2b53e88b526b

WORKDIR /code

COPY pyproject.toml uv.lock ./

# uv doesn't use pip, and scanners flag the packages the base image's pip vendors
RUN uv sync --locked && python -m pip uninstall -y pip

COPY . .

CMD ["uv", "run", "slack.py"]

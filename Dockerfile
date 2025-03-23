ARG CADDY_VERSION=2.9.1@sha256:cd261fc62394f1ff0b44f16eb1d202b4e71d5365c9ec866a4f1a9c5a52da9352
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

ARG CADDY_VERSION
FROM caddy:${CADDY_VERSION}

# Add standard labels following OCI image spec
LABEL org.opencontainers.image.title="Caddy with Cloudflare DNS"
LABEL org.opencontainers.image.description="Caddy web server with Cloudflare DNS module"
LABEL org.opencontainers.image.source="https://github.com/${GITHUB_REPOSITORY}"
LABEL org.opencontainers.image.vendor="fzymgc-house"
LABEL org.opencontainers.image.version="${CADDY_VERSION:-latest}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL maintainer="fzymgc-house"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

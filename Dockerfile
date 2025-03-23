FROM caddy:2.9-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/jasonlovesdoggo/caddy-defender \
    --with github.com/caddyserver/cache-handler

FROM caddy:2.9

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

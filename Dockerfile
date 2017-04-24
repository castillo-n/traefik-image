FROM traefik:1.2.1

COPY traefik.toml /etc/traefik/traefik.toml

COPY server.crt /server.crt

COPY server.key /server.key


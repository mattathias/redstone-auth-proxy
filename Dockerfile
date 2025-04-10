# Base image with Go 1.22+ to build Tailscale from source
FROM golang:1.22-alpine as tailscale-build

# Install dependencies to build Tailscale
RUN apk add --no-cache git make bash

# Clone the Tailscale repository
RUN git clone https://github.com/tailscale/tailscale.git /tailscale

# Set working directory
WORKDIR /tailscale

# Checkout a stable release (latest version as of now)
RUN git checkout v1.66.4

# Build Tailscale binaries
RUN go build -o /tailscale/tailscaled ./cmd/tailscaled && \
    go build -o /tailscale/tailscale ./cmd/tailscale

# Final image
FROM caddy:2.6.4-alpine

# Install Tailscale
COPY --from=tailscale-build /tailscale/tailscaled /usr/local/bin/tailscaled
COPY --from=tailscale-build /tailscale/tailscale /usr/local/bin/tailscale

# Install curl and dependencies for Tailscale to run
RUN apk add --no-cache curl iproute2

# Add the Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Add entrypoint script for both Tailscale and Caddy to run
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 80 for HTTP traffic and WebSockets
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

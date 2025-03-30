#!/bin/sh

# Start Tailscale and bring it up
/usr/local/bin/tailscaled &

# Wait for Tailscale to be ready
sleep 5

# Run Tailscale in the background to handle network setup
tailscale up --authkey tskey-auth-kofNucHhoV11CNTRL-Lssvm6QwWtUkYmM22So5tUCCHPNTS6ZjC  # Optional, use authkey for automated logins

# Start Caddy to serve the app
caddy run --config /etc/caddy/Caddyfile
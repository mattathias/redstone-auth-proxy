#!/bin/sh

# Start Tailscale and bring it up
tailscaled &

# Wait for Tailscale to be ready
sleep 5

# Run Tailscale in the background to handle network setup
tailscale up --authkey tskey-auth-kt7KQ9VvnC21CNTRL-kVzw5r42F4ZAotsPi6vX4ZLSDZSbVSRh2  # Optional, use authkey for automated logins

# Start Caddy to serve the app
caddy run --config /etc/caddy/Caddyfile
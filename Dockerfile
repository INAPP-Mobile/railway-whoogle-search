FROM docker.io/benbusby/whogle-search:1.2.3

LABEL org.opencontainers.image.source="https://github.com/INAPP-Mobile/railway-whogle-search"

# Whoogle listens on port 5000 internally.
ENV PORT=5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS "http://127.0.0.1:${PORT:-5000}/healthz" >/dev/null 2>&1 || exit 1

EXPOSE 5000

# Ensure Tor data directory exists with proper ownership for non-root user before switching
RUN mkdir -p /var/lib/tor && chown nobody:nogroup /var/lib/tor

# Run as non-root user for security (Railway constraint)
USER nobody

ENTRYPOINT ["/bin/sh", "-c", "misc/tor/start-tor.sh & ./run"]

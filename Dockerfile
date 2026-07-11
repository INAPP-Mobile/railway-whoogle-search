FROM docker.io/benbusby/whoogle-search:1.2.4

LABEL org.opencontainers.image.source="https://github.com/INAPP-Mobile/railway-whogle-search"

# Whoogle listens on port 5000 internally.
ENV PORT=5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS "http://127.0.0.1:${PORT:-5000}/healthz" >/dev/null 2>&1 || exit 1

EXPOSE 5000


USER nobody

ENTRYPOINT ["/bin/sh", "-c", "misc/tor/start-tor.sh & ./run"]

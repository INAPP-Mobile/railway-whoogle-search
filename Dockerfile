FROM docker.io/benbusby/whoogle-search:1.2.3

LABEL org.opencontainers.image.source="https://github.com/INAPP-Mobile/railway-whoogle-search"

# Healthcheck - use shell form so $PORT expands at runtime
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:5000/healthz || exit 1

# Expose port for documentation (Railway sets PORT env var)
EXPOSE 5000

# Whoogle runs on port 5000 internally
# Railway will override with $PORT if set
ENTRYPOINT ["/bin/sh", "-c", "misc/tor/start-tor.sh & ./run"]
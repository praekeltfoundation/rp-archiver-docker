FROM debian:stretch-slim

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates && \
  rm -rf /var/lib/apt/lists/*

RUN addgroup --system rp_archiver; \
    adduser --system --ingroup rp_archiver rp_archiver
USER rp_archiver

EXPOSE 8080
CMD ["rp-archiver"]
COPY rp-archiver /usr/local/bin/

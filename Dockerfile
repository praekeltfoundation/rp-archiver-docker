FROM debian:bullseye-slim as build

ARG ARCHIVER_REPO
ARG ARCHIVER_VERSION

RUN apt update && apt install -y wget
RUN wget -q -O archiver.tar.gz "https://github.com/$ARCHIVER_REPO/releases/download/v${ARCHIVER_VERSION}/rp-archiver_${ARCHIVER_VERSION}_linux_amd64.tar.gz"
RUN mkdir archiver
RUN tar -xzC archiver -f archiver.tar.gz

FROM debian:stretch-slim

RUN set -ex; \
    addgroup --system archiver; \
    adduser --system --ingroup archiver archiver

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates && \
  rm -rf /var/lib/apt/lists/*

COPY --from=build archiver/rp-archiver /usr/local/bin

USER archiver

ENTRYPOINT []
CMD ["rp-archiver"]
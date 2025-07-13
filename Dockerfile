ARG CNPG_TAG

FROM ghcr.io/tensorchord/cloudnative-vectorchord:${CNPG_TAG}

ARG CNPG_TAG
ARG PGVECTORS_TAG=v0.3.0
ARG TARGETARCH

# drop to root to install packages
USER root
ADD https://github.com/tensorchord/pgvecto.rs/releases/download/$PGVECTORS_TAG/vectors-pg${CNPG_TAG%.*}_${PGVECTORS_TAG#"v"}_$TARGETARCH.deb /tmp/pgvectors.deb
RUN apt-get install -y \
  /tmp/pgvectors.deb \
  && \
  rm -f /tmp/pgvectors.deb

USER postgres

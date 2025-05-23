ARG CNPG_TAG

FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG-minimal-bookworm

ARG CNPG_TAG
ARG VECTORCHORD_TAG=0.3.0
ARG PGVECTORS_TAG=v0.4.0
ARG TARGETARCH

# drop to root to install packages
USER root
ADD https://github.com/tensorchord/VectorChord/releases/download/$VECTORCHORD_TAG/postgresql-${CNPG_TAG%.*}-vchord_${VECTORCHORD_TAG#"v"}-1_$TARGETARCH.deb /tmp/vchord.deb
ADD https://github.com/tensorchord/pgvecto.rs/releases/download/$PGVECTORS_TAG/vectors-pg${CNPG_TAG%.*}_${PGVECTORS_TAG#"v"}_$TARGETARCH.deb /tmp/pgvectors.deb
RUN apt-get install -y \
  /tmp/vchord.deb \
  /tmp/pgvectors.deb \
  && \
  rm -f /tmp/vchord.deb /tmp/pgvectors.deb

USER postgres

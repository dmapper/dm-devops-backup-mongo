FROM mongo:4.1.6 as builder

RUN apt-get update && apt-get install -y -qq \
    bzip2 \
    wget \
    cron \
    gettext
WORKDIR /tmp

RUN wget https://github.com/restic/restic/releases/download/v0.9.3/restic_0.9.3_linux_amd64.bz2 \
    && bzip2 -d restic_0.9.3_linux_amd64.bz2 \
    && chmod +x restic_0.9.3_linux_amd64 \
    && mv restic_0.9.3_linux_amd64 restic

FROM mongo:4.1.6

RUN apt-get update && apt-get install -y -qq \
    bzip2 \
    curl \
    cron \
    gettext \
    wget

COPY --from=builder /tmp/restic /usr/bin/restic

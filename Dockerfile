FROM debian:buster-slim
LABEL maintainer="James Swineson <docker@public.swineson.me>"
ENV DEBIAN_FRONTEND=noninteractive

ADD apt /etc/apt/

RUN apt-get update && \
    apt-get upgrade -y && \
    # fix a bug
    mkdir -p /usr/share/doc/bird2/examples && \
    touch /usr/share/doc/bird2/examples/bird.conf && \ 
    apt-get install -y --no-install-recommends bird2 curl ca-certificates supervisor && \
    rm -r /var/lib/apt/lists/*

RUN curl -sSL https://git.io/get-mo -o /usr/local/bin/mo \
    && chmod +x /usr/local/bin/mo

ADD supervisor /etc/supervisor/
ADD bird /etc/bird/
COPY *.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh
RUN mkdir -p /run/bird

EXPOSE 179/tcp

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n" ]
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 CMD [ "healthcheck.sh" ]

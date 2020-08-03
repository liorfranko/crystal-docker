FROM crystallang/crystal
ENV LISTEN_ADDR="0.0.0.0"
ENV LISTEN_PORT=80
COPY ./src /usr/local/src/
HEALTHCHECK CMD cat /usr/local/src/home.cr --interval=5s --timeout=2s
CMD crystal /usr/local/src/home.cr
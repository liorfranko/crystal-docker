FROM crystallang/crystal
ENV LISTEN_ADDR="0.0.0.0"
ENV LISTEN_PORT=80
COPY ./www/ /usr/local/src/
CMD crystal /usr/local/src/home.cr
FROM gcr.io/prodarch-lab/ansible-docker:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl
RUN curl -L https://keybase.io/crystal/pgp_keys.asc | apt-key add -
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
RUN apt-get update
RUN apt-get install crystal -y
ENV LISTEN_ADDR="0.0.0.0"
ENV LISTEN_PORT=8080
CMD crystal /usr/local/src/home.cr
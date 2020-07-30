FROM gcr.io/prodarch-lab/ansible-docker:latest
RUN apt-get update && apt-get install -y curl
RUN curl -L https://keybase.io/crystal/pgp_keys.asc | apt-key add -
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
RUN apt-get update
RUN apt-get install crystal -y
CMD crystal /usr/local/src/home.cr

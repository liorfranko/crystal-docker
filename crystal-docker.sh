# shellcheck disable=SC2128
CODE_LOCATION=$(echo "$BASH_SOURCE" | awk -F 'crystal-docker' '{print $1 }')
docker build -t crystal_docker "$CODE_LOCATION/crystal-docker/"
docker run -it -p 8080:8080 -v "$CODE_LOCATION/crystal-docker/www:/usr/local/src/" crystal_docker



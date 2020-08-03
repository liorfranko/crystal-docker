# shellcheck disable=SC2128
CODE_LOCATION=$(echo "$BASH_SOURCE" | awk -F 'crystal-docker' '{print $1 }')
docker build -t liorf1/crystal_docker "$CODE_LOCATION/crystal-docker/"
docker run -it -p 80:80 liorf1/crystal_docker
# docker push liorf1/crystal_docker
docker build -t crystal_docker .
docker run -it -p 8080:8080 -v "/Users/$LOGNAME/Downloads/crystal-docker/www:/usr/local/src/" crystal_docker

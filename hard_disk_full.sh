echo Stopping any running containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

echo Removing all volumes
docker image prune -a
docker container prune
docker builder prune --all
docker system prune
docker system prune -a --volumes
docker volume ls -q | xargs docker volume rm


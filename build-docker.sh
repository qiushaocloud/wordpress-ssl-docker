docker pull wordpress:latest
#docker rmi -f qiushaocloud/wordpress-ssl-docker || true
docker build -t qiushaocloud/wordpress-ssl-docker .

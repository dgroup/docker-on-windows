#!/bin/bash

docker_remote_repository="<repository_name>"
docker_image_name="<image_name>"
docker_tags=(1.0 1.1.1 latest)

./docker.build-image.sh ${docker_image_name} $(pwd) Dockerfile

docker login ${docker_remote_repository}

for tagName in ${docker_tags[*]}
do
    full_image_name="${docker_remote_repository}/${docker_image_name}:${tagName}"
    docker tag ${docker_image_name} ${full_image_name}
    docker push ${full_image_name}
done

docker logout
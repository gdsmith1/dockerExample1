#!/bin/bash


#times a compose
start_time=$(date +%s)
docker compose build --no-cache
end_time=$(date +%s)
compose_time=$((end_time - start_time))



#times a bake
start_time=$(date +%s)
docker buildx bake --no-cache
end_time=$(date +%s)
bake_time=$((end_time - start_time))

#echo the results
echo "Compose: $compose_time seconds"
echo "Bake: $bake_time seconds"

# clean up (remove all images and volumes!)
docker rmi $(docker images -aq) --force
docker system prune -a --volumes -f
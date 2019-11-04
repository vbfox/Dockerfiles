source build.sh

docker push "${repo}:latest"
docker push "${repo}:${tag}"
docker push "${repo}:${altTag}"
docker push "${repo}:${shortTag}"
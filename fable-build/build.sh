repo=vbfox/fable-build
aspnet_version=3.0.100
mono_version=6.4.0.198
node_version=13.0.1
yarn_version=1.19.1

tag="buster-aspnet-${aspnet_version}-mono-${mono_version}-node-${node_version}-yarn-${yarn_version}"
altTag="buster-aspnet-${aspnet_version}-node-${node_version}"
shortTag="buster"

docker build . -t "${repo}:latest"

echo "Tagging ${repo}:latest with ${repo}:${tag}"
docker tag "${repo}:latest" "${repo}:${tag}"

echo "Tagging ${repo}:latest with ${repo}:${altTag}"
docker tag "${repo}:latest" "${repo}:${altTag}"

echo "Tagging ${repo}:latest with ${repo}:${shortTag}"
docker tag "${repo}:latest" "${repo}:${shortTag}"
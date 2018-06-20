$repo = 'vbfox/fable-build'
$aspnet_version = '2.1.301'
$mono_version = '5.12.0.226'
$node_version = '10.4.1'
$yarn_version = '1.7.0'

$tag = "stretch-aspnet-${aspnet_version}-mono-${mono_version}-node-${node_version}-yarn-${yarn_version}"
$shortTag = "stretch"

& docker build . -t "${repo}:latest"
& docker push "${repo}:latest"

& docker tag "${repo}:latest" "${repo}:${tag}"
& docker push "${repo}:${tag}"

& docker tag "${repo}:latest" "${repo}:${shortTag}"
& docker push "${repo}:${shortTag}"
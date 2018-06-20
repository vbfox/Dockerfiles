$repo = 'vbfox/fable-build'
$aspnet_version = '2.1.300'
$dotnet_version = '4.7.2-sdk'
$node_version = '8.11.2'
$yarn_version = '1.7.0'

$tag = "windowsservercore-1803-aspnet-${aspnet_version}-framework-${dotnet_version}-node-${node_version}-yarn-${yarn_version}"
$shortTag = "windowsservercore"

& docker build . -t "${repo}:${tag}"
& docker push "${repo}:${tag}"

& docker tag "${repo}:${tag}" "${repo}:${shortTag}"
& docker push "${repo}:${shortTag}"
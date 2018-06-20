$repo = 'vbfox/fable-build'
$aspnet_version = '2.1.301'
$dotnet_version = '4.7.2-sdk'
$node_version = '10.5.0'
$yarn_version = '1.7.0'

$tag = "windowsservercore-1803-aspnet-${aspnet_version}-framework-${dotnet_version}-node-${node_version}-yarn-${yarn_version}"
$altTag = "windowsservercore-aspnet-${aspnet_version}-node-${node_version}"
$shortTag = "windowsservercore"

& docker build . -t "${repo}:${tag}"
& docker push "${repo}:${tag}"

& docker tag "${repo}:${tag}" "${repo}:${altTag}"
& docker push "${repo}:${altTag}"

& docker tag "${repo}:${tag}" "${repo}:${shortTag}"
& docker push "${repo}:${shortTag}"
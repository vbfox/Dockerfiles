These images contains full build environments for [Fable](http://fable.io) (F# to JavaScript compiler) projects

## Content

* [.Net Core](https://www.microsoft.com/net/)
* .Net Framework (The Full one on Windows or [Mono](https://www.mono-project.com/) on Linux)
* [NodeJs](https://nodejs.org)
* [Yarn](https://yarnpkg.com)
* [Google Chrome](https://chrome.google.com) and it's [WebDriver](https://sites.google.com/a/chromium.org/chromedriver/) for client tests like [Selenium](https://docs.seleniumhq.org/) **LINUX IMAGE ONLY**

## Tags

* `latest`, `stretch`, `stretch-aspnet-2.1.401-node-10.9.0`, `stretch-aspnet-2.1.401-mono-5.12.0.226-node-10.9.0-yarn-1.9.4` [(fable-build/Dockerfile)](https://github.com/vbfox/Dockerfiles/blob/master/fable-build/Dockerfile)
* `windowsservercore`, `windowsservercore-aspnet-2.1.401-node-10.9.0` `windowsservercore-1803-aspnet-2.1.401-framework-4.7.2-sdk-node-10.9.0-yarn-1.9.4` [(fable-build-windows/Dockerfile)](https://github.com/vbfox/Dockerfiles/blob/master/fable-build-windows/Dockerfile)

## WebDriver Usage

### X Server

For the WebDriver to work an X server must be active, the image contains the virtual framebuffer implementation  [XVFB](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml).

To use it wrap your test script with `xvfb-run -a` like:

```bash
xvfb-run -a ./your-build-script-using-selenium.sh
```

### Disabling chrome sandbox
Chrome also need to be started without it's sandbox enabled. For cannopy :

```fsharp
open OpenQA.Selenium

let chromeNoSandbox =
    let chromeOptions = Chrome.ChromeOptions()
    chromeOptions.AddArgument("--no-sandbox")
    chromeOptions.AddArgument("--disable-extensions")
    chromeOptions.AddArgument("disable-infobars")
    chromeOptions.AddArgument("test-type")
    chromeOptions.AddArgument("--headless")
    ChromeWithOptions(chromeOptions)

let startBrowser() =
    start chromeNoSandbox
```
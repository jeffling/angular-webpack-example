Webpack + Angular + Bower + Gulp
================================

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jeffling/angular-webpack-example?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

*This template is kept bare-bones on purpose. If you have any questions or need advice on folder structure feel free to make an issue*

Minimal boilerplate with webpack (run from gulp) that supports angular (from bower), with some common settings.

It uses coffeescript, but you could very easily use the same configuration by stripping out the coffee loaders. 

It uses https://github.com/segmentio/khaos to generate the template.

```
npm install -g khaos
khaos create jeffling/angular-webpack-example <your project name>
```

What it has

* webpack configured with the bower path included `bower/<module name>`
* angular. Globally loaded
* karma. looks for .spec.coffee files.

Optional stuff:

* facebook/flo for live reloading in the browser.
* SASS loader


We use something close to this at @BenchLabs. It allows us to compose our entire app from strictly isolated angular modules. http://labs.bench.co/2015/1/21/componentized-angular

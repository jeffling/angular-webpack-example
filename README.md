Webpack + Angular + Bower + Gulp
================================

*Right now the template is a work in progress, but I've used this configuration for projects in production.*

Minimal boilerplate with webpack (run from gulp) that supports angular (from bower), with some common settings.

It uses https://github.com/segmentio/khaos to generate the template.

```
npm install -g khaos
khaos create jeffling/angular-webpack-example <your project name>
```

What it has

* webpack configured with the bower path included `bower/<module name>
* angular and karma. It loads angular globally.

Optional stuff:

* facebook/flo for live reloading in the browser.
* SASS loader

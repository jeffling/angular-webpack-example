# gulp plugins
gulp = require 'gulp'
changed = require 'gulp-changed'
gutil = require 'gulp-util'

# misc
spawn = require('child_process').spawn
argv = require('minimist')(process.argv.slice(2))

# webpack
webpack = require 'webpack'
webpackConfig = require './webpack.config'
ngminPlugin = require 'ngmin-webpack-plugin'

ports =
  livereload: 35729

paths =
  other: [
    'src/**'
    '!src/**/*.coffee'
    '!src/**/*.scss'
  ]
  targetDir: './target/'

gulp.task 'webpack', (cb) ->
  if argv.production  # --production option
    webpackConfig.plugins = webpackConfig.plugins.concat new ngminPlugin(),
      new webpack.optimize.UglifyJsPlugin()
    webpackConfig.devtool = false
    webpackConfig.debug = false

  if not 'watch' in argv._ # watch option
    webpack webpackConfig, (err, stats) ->
      if (err)
        throw new gutil.PluginError 'webpack', err
      gutil.log '[webpack]', stats.toString
        colors: true
      cb()
  else
    webpack webpackConfig
    .watch 200, (err, stats) ->
      if (err)
        throw new gutil.PluginError 'webpack', err
      gutil.log '[webpack]', stats.toString
        colors: true
    cb()

gulp.task 'other', ->
  gulp.src paths.other
  .pipe changed paths.targetDir
  .pipe gulp.dest paths.targetDir

# CLEARS THE TARGET DIRECTORY
rimraf = require 'rimraf'
gulp.task 'clearTarget', ->
  rimraf.sync paths.targetDir, gutil.log

gulp.task 'build', [
  'clearTarget'
  'webpack'
  'other'
]

gulp.task 'watch', ['build'], ->
  {{#fb-flo-livereloading}}
  fs = require 'fs'
  path = require 'path'
  flo = require 'fb-flo'
  flo paths.targetDir,
    port: 8888
    host: 'localhost'
    verbose: false
    glob: [
      '**/*.js'
      '**/*.css'
      '**/*.html'
    ]
  , (filepath, callback) ->
    url = filepath
    reload = true # set as true as angular doesn't support hotswapping
    if (path.extname filepath) is '.html'
      url = '/'
    callback
      resourceURL: url
      contents: fs.readFileSync paths.targetDir + filepath
      reload: reload
  {{/fb-flo-livereloading}}

  gulp.watch paths.other, ['other']

path = require 'path'
webpack = require 'webpack'
ngminPlugin = require 'ngmin-webpack-plugin'

appRoot = "#{__dirname}/src"
{{#bower}}
bowerRoot = "#{__dirname}/bower_components"
{{/bower}}

styleRoot = "#{appRoot}/assets/styles"

module.exports =
  cache: true
  debug: true

  # The entry point
  entry: [
    "#{appRoot}/app.coffee"
  ]

  output:
    path: './target'
    filename: 'bundle.js'
    chunkFilename: "[id].bundle.js"

  module:
    loaders: [
      # required to write 'require('./style.css')'
      test: /\.css$/
      loaders: ['style','css']
    ,
    {{#sass}}
      # required to write 'require('./style.scss')'
      test: /\.scss$/
      loaders: ['style','css',"sass?includePaths[]=#{styleRoot}"]
    ,
    {{/sass}}
      test: /\.coffee$/
      loader: 'coffee'
    ,
      # require raw html for partials
      test: /\.html$/
      loader: 'raw'
    ,
      # required for bootstrap icons
      test: /\.woff$/
      loader: 'url?prefix=font/&limit=5000&mimetype=application/font-woff'
    ,
      test: /\.ttf$/
      loader: 'file?prefix=font/'
    ,
      test: /\.eot$/
      loader: 'file?prefix=font/'
    ,
      test: /\.svg$/
      loader: 'file?prefix=font/'
    ,
      test: /[\/\\]angular\.js$/
      loader: "exports?angular"
    ]

    # don't parse some dependencies to speed up build.
    # can probably do this non-AMD/CommonJS deps
    noParse: [
      path.join bowerRoot, '/angular'
      path.join bowerRoot, '/angular-route'
      path.join bowerRoot, '/angular-mocks'
      path.join bowerRoot, '/jquery'
    ]

  resolve:
    alias:
      bower: bowerRoot

    extensions: [
      ''
      '.js'
      '.coffee'
      '.scss'
      '.css'
    ]

    root: appRoot

  plugins: [
    # bower.json resolving
    new webpack.ResolverPlugin [
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin "bower.json", ["main"]
    ], ["normal", "loader"]

    # disable dynamic requires (disable moment langs)
    new webpack.ContextReplacementPlugin(/.*$/, /a^/)

    ### ngmin annotation
    new ngminPlugin() # or, new ngminPlugin({dynamic: true}) for dynamic mode
    ###

    # # uglify
    # new webpack.optimize.UglifyJsPlugin()
  ]

  devtool: 'eval'

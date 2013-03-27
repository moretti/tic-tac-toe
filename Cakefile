{exec} = require 'child_process'
path   = require 'path'

output = 'www/js/app.js'
sourceFolder = 'src'
coffeeFiles = [
  'namespace'
  'helpers'
  'event'
  'mark'
  'player'
  'board'
  'ai'
  'game'
  'ui'
]

run = (command, callback) ->
  exec command, (err, stdout, stderr) ->
    console.warn stderr if stderr
    console.log stdout if stdout
    callback?() unless err

build = (callback) ->
  sources = (path.join sourceFolder, "#{file}.coffee" for file in coffeeFiles).join ' '
  run "coffee -j #{output} -c #{sources}", callback

task "build", "Compile CoffeeScript source files", ->
  build()
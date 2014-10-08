template = require 'templates/platforms'
PlatformsSingleton = require 'collections/platforms'

class Platforms extends Backbone.View

  initialize: () ->


    @listenTo PlatformsSingleton, "sync", ->
      @render()

  render: () ->
    @$el.html template platforms: PlatformsSingleton.models
    @el

module.exports = Platforms

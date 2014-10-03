template = require 'templates/platforms'
Platforms = require 'collections/platforms'

Menu = Backbone.View.extend

  initialize: () ->

  	@p = new Platforms
  	@listenToOnce @p, "sync", ->
  		@render()

  	@p.fetch()

  render: () ->
    @$el.html template platforms: @p.models
    @el

module.exports = Menu
template = require 'templates/home'
Platforms = require 'collections/platforms'

Menu = Backbone.View.extend

  initialize: () ->

  	@p = new Platforms
  	@listenToOnce @p, "sync", ->
  		@render()

  	@p.url = 'http://test:test@localhost:3001/resource/platforms'
  	@p.fetch()

  render: () ->
    @$el.html template platforms: @p.models
    @el

module.exports = Menu
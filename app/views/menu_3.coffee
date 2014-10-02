template = require 'templates/menu_3'
Platforms = require 'collections/platforms'

Menu = Backbone.View.extend

  initialize: () ->

  	@p = new Platforms
  	@listenToOnce @p, "sync", ->
  		@render()

  	@p.url = 'http://localhost:3001/platforms'
  	@p.fetch()

  render: () ->
    @$el.html template platforms: @p.models
    @el

module.exports = Menu
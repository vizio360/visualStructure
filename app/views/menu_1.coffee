template = require 'templates/menu_1'

Menu = Backbone.View.extend

  id: "menu1"

  initialize: () ->

  render: () ->
    @$el.html template()
    @el

module.exports = Menu

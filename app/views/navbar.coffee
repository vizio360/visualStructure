template = require 'templates/navbar'

class NavBar extends Backbone.View
  tagName: "nav"
  className: "navbar navbar-default navbar-fixed-top"
  attributes:
    role: "navigation"
  ###
  initialize: (options) ->

    options.router.on 'route:menu_1', () =>
      @page = 'menu_1'
      @render()

    options.router.on 'route:menu_2', () =>
      @page = 'menu_2'
      @render()

    options.router.on 'route:menu_3', () =>
      @page = 'menu_3'
      @render()

  ###
  render: () ->
    if not @page then @page = Backbone.history.fragment
    if @page is '' then @page = 'menu_1'
    @$el.html template page: @page
    @el

module.exports = NavBar

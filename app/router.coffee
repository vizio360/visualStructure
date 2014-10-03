login = require 'views/login'
platformsView = require 'views/platforms'

Router = Backbone.Router.extend

  initialize: () ->

  loginPage: ->
    @login = new login
      el: $('.login')
      router: @
    @login.on "success", =>
      @login.deactivate()
      @navigate "platforms", trigger: true
    @login.render()

  platforms: ->
    @platformsView = new platformsView
      el: $('.main-content')
    @platformsView.render()

  routes:
    ''                  : 'loginPage'
    'login'             : 'loginPage'
    'platforms'         : 'platforms'
    'platforms/:id'     : 'showPlatform'
    '*EverythingElse'   : 'loginPage'

module.exports = Router
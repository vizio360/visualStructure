login = require 'views/login'
platformsView = require 'views/platforms'
PlatformsSingleton = require 'collections/platforms'
UserSingleton = require 'models/user'

class Router extends Backbone.Router

  initialize: () ->

  loginPage: ->
    if UserSingleton.loggedIn
      return @navigate "platforms", trigger: true
    @login = new login
      el: $('.login')
      router: @
    @login.on "success", =>
      @login.deactivate()
      @startPolling()
      @navigate "platforms", trigger: true
    @login.render()

  startPolling: ->
    setInterval ->
      PlatformsSingleton.fetch()
    , 5000

  platformsPage: ->
    if not UserSingleton.loggedIn
      return @navigate "login", trigger: true
    @platformsView = new platformsView
      el: $('.main-content')
    @platformsView.render()

  routes:
    ''                  : 'loginPage'
    'login'             : 'loginPage'
    'platforms'         : 'platformsPage'
    'platforms/:id'     : 'showPlatform'
    '*EverythingElse'   : 'loginPage'

module.exports = Router

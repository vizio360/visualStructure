login = require 'views/login'
platformsView = require 'views/platforms'
PlatformsSingleton = require 'collections/platforms'
UserSingleton = require 'models/user'
navbar = require 'views/navbar'
menu1 = require 'views/menu_1'
ViewManager = require 'lib/viewManager'

class Router extends Backbone.Router

  setupViews: ->
    @viewManager = new ViewManager
    console.log $('.page-content')
    @viewManager.setElement $('.page-content')
    @platformsView = new platformsView
    @menu1 = new menu1
    @viewManager.add @platformsView
    @viewManager.add @menu1

  loginPage: ->
    if UserSingleton.loggedIn
      return @navigate "home", trigger: true
    @login = new login
      el: $('.login')
    @login.on "success", =>
      @login.deactivate()
      @setupViews()
      @navigate "home", trigger: true
    @login.render()

  setupNavBar: ->
    return if @navbar?
    @navbar = new navbar
    $('#main-content').prepend @navbar.render()

  homePage: ->
    @authenticationCheck =>
      @setupNavBar()
      @menu1.render()
      @viewManager.activate @menu1

  startPolling: ->
    setInterval ->
      PlatformsSingleton.fetch()
    , 5000

  platformsPage: ->
    @authenticationCheck =>
      @startPolling()
      @platformsView.render()
      @viewManager.activate @platformsView

  authenticationCheck: (cb) ->
    if not UserSingleton.loggedIn
      return @navigate "login", trigger: true
    cb()

  routes:
    ''                  : 'loginPage'
    'login'             : 'loginPage'
    'home'              : 'homePage'
    'platforms'         : 'platformsPage'
    'platforms/:id'     : 'showPlatform'
    '*EverythingElse'   : 'loginPage'

module.exports = Router

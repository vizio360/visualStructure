login = require 'views/login'
platformsView = require 'views/platforms'
graphView = require 'views/graph'
PlatformsSingleton = require 'collections/platforms'
UserSingleton = require 'models/user'
navbar = require 'views/navbar'
menu1 = require 'views/menu_1'
ViewManager = require 'lib/viewManager'
EntityFactory = require("lib/ces/entityFactory").Singleton

class Router extends Backbone.Router

  setupViews: ->
    @viewManager = new ViewManager
    console.log $('.page-content')
    @viewManager.setElement $('.page-content')
    @platformsView = new platformsView
    @menu1 = new menu1
    @graphView = new graphView
    @viewManager.add @platformsView
    @viewManager.add @menu1
    @viewManager.add @graphView

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

  graphPage: ->
    @authenticationCheck =>
      @createSomeEntities()
      @graphView.render()
      @graphView.start()
      @viewManager.activate @graphView

  graphEditPage: ->
    @authenticationCheck =>
      @graphView.render(editable = true)
      @graphView.start()
      @viewManager.activate @graphView

  createSomeEntities: ->
    EntityFactory.deleteAll()
    all = []
    for i in [1..5]
      e = EntityFactory.createEntity()
      e.addComponent
        position:
          x: _.random 100, 700
          y: _.random 100, 500
        size:
          width: 20
          height: 20
      all.push e
    for i in [1..4]
      c = EntityFactory.createEntity()
      c.addComponent
        connection:
          from: all[i-1].getId()
          to: all[i].getId()

  authenticationCheck: (cb) ->
    if not UserSingleton.loggedIn
      return @navigate "login", trigger: true
    cb()

  routes:
    ''                  : 'loginPage'
    'login'             : 'loginPage'
    'home'              : 'homePage'
    'platforms'         : 'platformsPage'
    'graph'             : 'graphPage'
    'graphEdit'         : 'graphEditPage'
    '*EverythingElse'   : 'loginPage'

module.exports = Router

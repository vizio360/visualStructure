login = require 'views/login'
home = require 'views/home'

Router = Backbone.Router.extend

  initialize: () ->

  loginPage: ->
    @login = new login
      el: $('.login')
      router: @
    @login.on "success", =>
      @login.deactivate()
      @navigate "home", trigger: true
    @login.render()

  home: ->
    console.log "home"
    @home = new home
      el: $('.main-content')
    @home.render()

  routes:
    ''            : 'loginPage'
    'login'       : 'loginPage'
    'home'        : 'home'

module.exports = Router
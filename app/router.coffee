login = require 'views/login'

Router = Backbone.Router.extend

  initialize: () ->

  loginPage: ->
    @login = new login
      el: $('.root-view')
      router: @
    @login.on "success", =>
      @navigate "home"
    @login.render()

  home: ->
    console.log "home"

  routes:
    ''            : 'loginPage'
    'menu_1'      : 'home'

module.exports = Router
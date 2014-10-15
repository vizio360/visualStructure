class User extends Backbone.Model

  url: "/api/resource/platforms"

  initialize: () ->
    @loggedIn = false

  validate: (attrs, options) ->
    if not attrs.username or not attrs.password
      return "You need to provide both username and password"

  authenticate: (callback) ->
    basicAuth = "Basic " + btoa(@get('username')+":"+@get('password'))
    Backbone.ajax @url,
      headers:
        Authorization: basicAuth
      complete: (xhr, status) =>
        if status is "success"
          @loggedIn = true
          @_remapBackboneAjaxWithAuth basicAuth
        callback status

  _remapBackboneAjaxWithAuth: (auth) ->
    # adding Authorization header to all Backbone
    # requests if user is logged in
    # NB not sure if this is the best way
    # but this way I can unit test this.
    Backbone.ajax = () =>
      if @loggedIn
        opts = arguments['1'] or arguments['0']
        opts.headers ?= {}
        opts.headers["Authorization"] = auth
      return Backbone.$.ajax.apply(Backbone.$, arguments);

  logout: ->
    @loggedIn = false

module.exports = new User

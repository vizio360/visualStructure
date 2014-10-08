class User extends Backbone.Model
  url: "/api/resource/platforms"

  initialize: () ->
    @loggedIn = false

  validate: (attrs, options) ->
    if not attrs.username or not attrs.password
      return "You need to provide both username and password"

  authenticate: (callback) ->
    Backbone.ajax @url,
      beforeSend: (xhr) =>
        basic = btoa(@get('username')+":"+@get('password'))
        xhr.setRequestHeader("Authorization", "Basic " + basic)
      ,
      complete: (xhr, status) =>
        if status is "success"
          @loggedIn = true
          Backbone.$.ajaxSetup
            beforeSend: (xhr) =>
              basic = btoa(@get('username')+":"+@get('password'))
              xhr.setRequestHeader("Authorization", "Basic " + basic)
        callback status

module.exports = new User

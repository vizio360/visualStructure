User = Backbone.Model.extend
  initialize: () ->

  validate: (attrs, options) ->
    console.log attrs
    if not attrs.username or not attrs.password
      return "You need to provide both username and password" 

  authenticate: (url, callback) ->
    Backbone.ajax url,
      beforeSend: (xhr) =>
          basic = btoa(@get('username')+":"+@get('password'))
          xhr.setRequestHeader("Authorization", "Basic " + basic)
        ,
        complete: (xhr, status) ->
          callback status

module.exports = User
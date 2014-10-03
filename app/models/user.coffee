User = Backbone.Model.extend
  url: "/api/resource/platforms"

  initialize: () ->

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
            Backbone.$.ajaxSetup
              beforeSend: (xhr) =>
                basic = btoa(@get('username')+":"+@get('password'))
                xhr.setRequestHeader("Authorization", "Basic " + basic)
          callback status

module.exports = User
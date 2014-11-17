describe 'User model', ->

  user = null
  expectedUserPasswordNotProvidedErrorMsg =
    "You need to provide both username and password"

  beforeEach ->
    jasmine.addMatchers(customMatchers)
    user = require('models/user')

  afterEach ->
    $.mockjax.clear()
    user.logout()

  it 'is defined', ->
    expect(user).toBeDefined()

  it 'is a model', ->
    expect(user).toBeAModel()

  it 'is a Singleton', ->
    expect(user).toBeASingleton('models/user')

  it "doesn't validate if no user and/or password are provided", ->
    checkValidation = (user) ->
      expect(user.isValid()).toBeFalsy()
      error = user.validationError
      expect(error).toBeDefined()
      expect(user.validationError)
        .toBe expectedUserPasswordNotProvidedErrorMsg

    cases = [
        user: "simone"
        password: ""
      ,
        user: ""
        password: "something"
      ,
        user: ""
        password: ""
      ,
        user: undefined
        password: "something"
      ,
        user: "something"
        password: undefined
      ,
        user: undefined
        password: undefined
    ]
    for c in cases
      user.set c
      checkValidation user

  it "correctly keeps login status is authentication succeeds", (done) ->
    $.mockjax
      url: user.url
      status: 200

    user.authenticate (status) ->
      expect(status).toBe("success")
      expect(user.loggedIn).toBe(true)
      done()

  it "correctly sets authorization headers when authenticating", (done) ->
    credentials =
      username: "simone"
      password: "pwd"

    user.set credentials
    $.mockjax
      url: user.url
      status: 200
      requestHeaders:
        Authorization:
          "Basic "+btoa(credentials.username+":"+credentials.password)

    user.authenticate (status) ->
      expect(status).toBe("success")
      done()

  it "correctly sets authorization headers for all subsequent calls", (done) ->
    credentials =
      username: "simone"
      password: "pwd"

    user.set credentials

    $.mockjax
      url: user.url
      status: 200
      requestHeaders:
        Authorization:
          "Basic "+btoa(credentials.username+":"+credentials.password)

    user.authenticate (status) ->
      Backbone.ajax user.url,
        complete: (xhr, status) ->
          expect(status).toBe("success")
          done()

  it "notifies if authentication fails", (done) ->
    credentials =
      username: "simone"
      password: "pwd"

    user.set credentials
    $.mockjax
      url: user.url
      status: 401
      requestHeaders:
        Authorization:
          "Basic "+btoa(credentials.username+":"+credentials.password)

    user.authenticate (status) ->
      expect(status).toBe("error")
      done()

  it "correctly logs the user out", (done) ->
    credentials =
      username: "simone"
      password: "pwd"

    user.set credentials

    $.mockjax
      url: user.url
      status: 200
      requestHeaders:
        Authorization:
          "Basic "+btoa(credentials.username+":"+credentials.password)

    $.mockjax
      url: user.url
      status: 401

    user.authenticate (status) ->
      user.logout()
      Backbone.ajax user.url,
        complete: (xhr, status) ->
          expect(status).toBe("error")
          done()

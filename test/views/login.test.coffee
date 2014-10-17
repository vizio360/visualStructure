describe "Login View", ->

  loginClass = require "views/login"
  login = null

  beforeEach ->
    jasmine.addMatchers(customMatchers)
    login = new loginClass
      el: $('<div/>')

  it "can be instantiated", ->
    expect(login).toBeDefined()

  it "is a View", ->
    expect(login).toBeAView()

  it "doesn't show error message on render", ->
    login.render()
    errorMessage = login.$("#errorMessage")
    result = errorMessage.hasClass('hidden')
    expect(result).toBe(true)

  it "hides itself when deactivated", ->
    login.render()
    login.deactivate()
    expect(login.$el.hasClass('hidden')).toBe(true)

  it "shows itself when activated", ->
    login.render()
    login.activate()
    expect(login.$el.hasClass('hidden')).not.toBe(true)

  it "has a form defined", ->
    login.render()
    expect(login).toContainHtmlElement("form")

  it "has a signin dialog container", ->
    login.render()
    expect(login).toContainHtmlElement("#signinDialog")

  it "has an error message container", ->
    login.render()
    expect(login).toContainHtmlElement("#errorMessage")

  it "has an email input", ->
    login.render()
    expect(login).toContainHtmlElement(".login-email")

  it "has a password input", ->
    login.render()
    expect(login).toContainHtmlElement(".login-password")

  it "has a submit element", ->
    login.render()
    expect(login).toContainHtmlElement(":submit")

  it "shows an error message if wrong credentials provided", ->
    login.render()
    login.$(".login-email input").val("blah")
    login.$(".login-password input").val("blah")
    user = require "models/user"
    spyOn(user, "authenticate").and.callFake (cb) ->
      cb "error"
    login.$el.trigger("submit")
    errorMessage = login.$("#errorMessage")
    result = errorMessage.hasClass('hidden')
    expect(result).toBe(false)

  it "shows an error message if user model doesn't validate", ->
    login.render()
    user = require "models/user"
    spyOn(user, "validate").and.returnValue("some kind of error")
    login.$el.trigger("submit")
    errorMessage = login.$("#errorMessage")
    result = errorMessage.hasClass('hidden')
    expect(result).toBe(false)

  it "doesn't shows an error message if correct credentials provided", ->
    login.render()
    login.$(".login-email input").val("blah")
    login.$(".login-password input").val("blah")
    user = require "models/user"
    spyOn(user, "authenticate").and.callFake (cb) ->
      cb "success"
    login.$el.trigger("submit")
    errorMessage = login.$("#errorMessage")
    result = errorMessage.hasClass('hidden')
    expect(result).toBe(true)

  it "triggers a success event if authentication successful", (done) ->
    login.render()
    login.$(".login-email input").val("blah")
    login.$(".login-password input").val("blah")
    login.on "success", ->
      done()
    user = require "models/user"
    spyOn(user, "authenticate").and.callFake (cb) ->
      cb "success"
    login.$el.trigger("submit")

  it "shows a loading screen while communicating with server", (done) ->
    login.render()
    login.$(".login-email input").val("blah")
    login.$(".login-password input").val("blah")
    user = require "models/user"
    spyOn(user, "authenticate").and.callFake (cb) ->
      setTimeout ->
        expect(login.$("#signinDialog").css('display')).toEqual('block')
        cb "success"
        setTimeout ->
          expect(login.$("#signinDialog").css('display')).toEqual('none')
          done()
        , 1000 #this is to wait until the fade out effect has finished
      , login.signinDialogDelay + 1000
    login.$el.trigger("submit")

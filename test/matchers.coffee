customMatchers =
  toBeACollection: (utils, customEqualityTesters) ->
    compare: (actual, expected) ->
      expected = Backbone.Collection
      pass = actual instanceof expected
      message = "Expected #{actual} not to be an instance of #{expected}"
      if not pass
        message = "Expected #{actual} to be an instance of #{expected}"
      result =
        pass: pass
        message: message

  toBeAModel: (utils, customEqualityTesters) ->
    compare: (actual, expected) ->
      expected = Backbone.Model
      pass = actual instanceof expected
      message = "Expected #{actual} not to be an instance of #{expected}"
      if not pass
        message = "Expected #{actual} to be an instance of #{expected}"
      result =
        pass: pass
        message: message

  toBeAView: (utils, customEqualityTesters) ->
    compare: (actual, expected) ->
      expected = Backbone.View
      pass = actual instanceof expected
      message = "Expected #{actual} not to be an instance of #{expected}"
      if not pass
        message = "Expected #{actual} to be an instance of #{expected}"
      result =
        pass: pass
        message: message

  toBeASingleton: (utils, customEqualityTesters) ->
    compare: (actual, expected) ->
      expected = require expected
      pass = utils.equals(actual, expected, customEqualityTesters)
      message = "Expected #{actual} not to be Singleton of #{expected}"
      if not pass
        message = "Expected #{actual} to be a Singleton of #{expected}"
      result =
        pass: pass
        message: message

  toContainHtmlElement: (utils, customEqualityTesters) ->
    compare: (actual, elementSelector) ->
      if actual instanceof Backbone.View
        actual = actual.$el
      element = actual.find(elementSelector)[0]
      pass = element?
      message = "Expected #{actual} not to contain a #{elementSelector} HTML element"
      if not pass
        message = "Expected #{actual} to contain a #{elementSelector} HTML element"
      result =
        pass: pass
        message: message

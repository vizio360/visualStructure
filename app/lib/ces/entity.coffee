Module = require "lib/mixin/module"

generateUniqueId = ->
  s4 = ->
    Math.floor((1 + Math.random()) * 0x10000)
                   .toString(16)
                   .substring(1);
  s4() + "-" + s4()

class Entity extends Module

  constructor: (@factory, id) ->
    @_id = id if id?

  getId: ->
    @_id ?= generateUniqueId()

  addComponent: (componentObj) ->
    name = null
    for key, value of componentObj
      name = key
      @factory.trackEntity name, @
    @extend componentObj

  removeComponent: (componentName) ->
    delete @[componentName]
    @factory.untrackEntity componentName, @

module.exports = Entity

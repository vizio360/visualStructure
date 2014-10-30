Entity = require "lib/ces/entity"

class EntityFactory

  constructor: ->
    @entityList = {}

  createEntity: ->
    new Entity(@)

  trackEntity: (componentName, entity) ->
    @entityList[componentName] ?= []
    @entityList[componentName].push entity

  untrackEntity: (componentName, entity) ->
    @entityList[componentName] = _.without @entityList[componentName], entity

  getEntitiesWith: (components...) ->
    if not components? or components.length is 0
      throw new Error("EntityFactory::getEntitiesWith need to provide at least one component name!!")
    result = @entityList[components[0]]
    for component in components[1..]
      result = _.intersection result, @entityList[component]
    result

module.exports =
  Singleton: new EntityFactory
  Klass: EntityFactory

Entity = require "lib/ces/entity"

class EntityFactory

  setupEntityList: ->
    @entityList = {}

  constructor: ->
    @setupEntityList()

  createEntity: (id) ->
    new Entity(@, id)

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

  all: ->
    allEntities = []
    _.each @entityList, (value, key, list) ->
      allEntities = _.union allEntities, value
    allEntities

  deleteAll: ->
    @setupEntityList()

module.exports =
  Singleton: new EntityFactory
  Klass: EntityFactory

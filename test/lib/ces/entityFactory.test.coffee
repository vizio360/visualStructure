describe "Entity Factory", ->
  EntityFactoryClass = require("lib/ces/entityFactory").Klass
  EntityFactory = null
  EntityClass = require "lib/ces/entity"
  position = require "lib/ces/components/position"
  size = require "lib/ces/components/size"

  beforeEach ->
    EntityFactory = new EntityFactoryClass

  it 'provides a Singleton', ->
    singleton = require("lib/ces/entityFactory").Singleton
    singleton2 = require("lib/ces/entityFactory").Singleton
    expect(singleton).toEqual(singleton2)

  it "can create a new entity", ->
    entity = EntityFactory.createEntity()
    expect(entity).toEqual(jasmine.any(EntityClass))

  it "can create a new entity with a specific id", ->
    entity = EntityFactory.createEntity("myId")
    expect(entity.getId()).toEqual("myId")

  it "can retrieve all entities with a specific component", ->
    entity = EntityFactory.createEntity()
    entity.addComponent position
    entity2 = EntityFactory.createEntity()
    entity2.addComponent size
    expect(EntityFactory.getEntitiesWith("position").length).toBe(1)
    expect(EntityFactory.getEntitiesWith("position", "size").length).toBe(0)
    entity.addComponent size
    entity2.addComponent position
    expect(EntityFactory.getEntitiesWith("position", "size").length).toBe(2)
    entity.removeComponent "size"
    expect(EntityFactory.getEntitiesWith("position", "size").length).toBe(1)

  it "raises an exception if no components are passed to getEntitiesWith", ->
    expect( -> EntityFactory.getEntitiesWith()).toThrow()

  it "can retreive all the entities", ->
    expect(EntityFactory.all().length).toBe 0
    entity = EntityFactory.createEntity()
    entity.addComponent position
    entity.addComponent size
    entity2 = EntityFactory.createEntity()
    entity2.addComponent size
    expect(EntityFactory.all().length).toBe 2

  it "is possible to delete all the entities", ->
    entity = EntityFactory.createEntity()
    entity.addComponent position
    entity.addComponent size
    entity2 = EntityFactory.createEntity()
    entity2.addComponent size
    expect(EntityFactory.all().length).toBe 2
    EntityFactory.deleteAll()
    expect(EntityFactory.all().length).toBe 0


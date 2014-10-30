describe "Size component", ->

  size = require "lib/ces/components/size"
  EntityFactoryClass = require("lib/ces/entityFactory").Klass
  EntityFactory = null
  entity = null

  beforeEach ->
    EntityFactory = new EntityFactoryClass()
    entity = EntityFactory.createEntity()

  it "is correctly defined", ->
    expect(size.size).toEqual(jasmine.any(Object))

  it "can be different for different entities", ->
    entity.addComponent size
    entity.size.width = 150
    entity2 = EntityFactory.createEntity()
    entity2.addComponent size
    entity2.size.width = -600
    expect(entity.size.width).toBe(150)
    expect(entity2.size.width).toBe(-600)

  it "can be added to an entity", ->
    entity.addComponent size
    expect(entity.size.width).toBeDefined()
    expect(entity.size.height).toBeDefined()

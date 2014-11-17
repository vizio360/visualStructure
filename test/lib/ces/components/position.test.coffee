describe "Position component", ->

  position = require "lib/ces/components/position"
  EntityFactoryClass = require("lib/ces/entityFactory").Klass
  EntityFactory = null
  entity = null

  beforeEach ->
    EntityFactory = new EntityFactoryClass()
    entity = EntityFactory.createEntity()

  it "is correctly defined", ->
    expect(position.position).toEqual(jasmine.any(Object))

  it "can be different for different entities", ->
    entity.addComponent position
    entity.position.x = 150
    entity2 = EntityFactory.createEntity()
    entity2.addComponent position
    entity2.position.x = -600
    expect(entity.position.x).toBe(150)
    expect(entity2.position.x).toBe(-600)

  it "can be added to an entity", ->
    entity.addComponent position
    expect(entity.position.x).toBeDefined()
    expect(entity.position.y).toBeDefined()

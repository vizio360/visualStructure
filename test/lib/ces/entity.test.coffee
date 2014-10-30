describe "Entity", ->

  EntityFactoryClass = require("lib/ces/entityFactory").Klass
  EntityClass = require "lib/ces/entity"
  EntityFactory = null

  Module = require "lib/mixin/module"
  entity = null

  beforeEach ->
    EntityFactory = new EntityFactoryClass()
    entity = EntityFactory.createEntity()

  it "can be defined", ->
    expect(entity).toBeDefined()

  it "extends Module", ->
    result = entity instanceof Module
    expect(result).toBe(true)

  it "can be set up with a specific id", ->
    ent = new EntityClass(EntityFactory, "myId")
    expect(ent.getId()).toBe("myId")

  it "has a unique id", ->
    entity2 = EntityFactory.createEntity()
    entity3 = EntityFactory.createEntity()
    expect([entity2.getId(), entity3.getId()]).not.toContain entity.getId()
    expect([entity.getId(), entity3.getId()]).not.toContain entity2.getId()
    expect([entity.getId(), entity2.getId()]).not.toContain entity3.getId()

  it "always returns the same unique id for an entity", ->
    expect(entity.getId()).toBe(entity.getId())

  it "can add components", ->
    component =
      size:
        width: 100
        height: 200

    entity.addComponent component
    expect(entity.size.width).toBe 100
    expect(entity.size.height).toBe 200

  it "can remove components", ->
    component =
      size:
        width: 100
        height: 200

    entity.addComponent component
    entity.removeComponent "size"
    expect(entity.size).not.toBeDefined()


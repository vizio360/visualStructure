EntityFactory = require('lib/ces/entityFactory').Singleton

class Drawing

  setup: (@fabricCanvas) ->
    @entitiesDrawn = {}


  execute: ->
    entities = EntityFactory.getEntitiesWith "position", "size"
    connections = EntityFactory.getEntitiesWith "connection"
    if connections?
      for connection in connections
        @createConnection(connection, entities)
    if entities?
      for entity in entities
        @createItem(entity)

  createItem: (entity) ->
    rect = @entitiesDrawn[entity.getId()]
    if not rect?
      rect = new fabric.Rect()
      @entitiesDrawn[entity.getId()] = rect
      rect.hasControls = rect.hasBorders = false
      @fabricCanvas.add rect
      rect.entity = entity
    rect.set
      left: entity.position.x
      top: entity.position.y
      width: entity.size.width
      height: entity.size.height

  createConnection: (entity, entities) ->
    from = entity.connection.from
    to = entity.connection.to
    entityFrom = @find(from, entities)
    entityTo = @find(to, entities)

    coords = [
      entityFrom.position.x,
      entityFrom.position.y,
      entityTo.position.x,
      entityTo.position.y
    ]

    line = @entitiesDrawn[entity.getId()]
    if not line?
      line = new fabric.Line()
      @entitiesDrawn[entity.getId()] = line
      @fabricCanvas.add line
      line.entity = entity
    line.set
      x1: coords[0]
      y1: coords[1]
      x2: coords[2]
      y2: coords[3]
      fill: 'red'
      stroke: 'red'
      strokeWith: 4
      selectable: false


  find: (id, entities) ->
    _.find entities, (e) ->
      e.getId() is id

module.exports = Drawing

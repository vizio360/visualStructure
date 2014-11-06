class ViewManager

  setElement: (@el) ->

  checkViewIsTracked: (view, msg) ->
    if not @views?[view.id]?
      return throw new Error(msg+" - "+view)

  add: (view) ->
    @views ?= {}
    if @views[view.id]?
      return throw new Error("Trying to add the same view multiple times - "+view)
    @views[view.id] = $('<div class="hidden"/>')
    view.setElement(@views[view.id])
    @el.append @views[view.id]

  activate: (view) ->
    @checkViewIsTracked(view, "Trying to activate a view that has not been added")
    @el.children("div").addClass("hidden")
    @views[view.id].removeClass("hidden")

  remove: (view) ->
    @checkViewIsTracked(view, "Trying to remove a view that has not been added")
    @views[view.id].remove()
    delete @views[view.id]

module.exports = ViewManager

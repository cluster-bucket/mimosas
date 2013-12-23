((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./view_component'], factory
    return
  else if typeof exports is 'object'
    ViewComponent = require './view_component'
    module.exports = factory(ViewComponent)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    ViewComponent = root.Mimosas.ViewComponent
    root.Mimosas.ViewLeaf = factory(ViewComponent)
    return
) @, (ViewComponent) ->

  class ViewLeaf extends ViewComponent
  
  ViewLeaf

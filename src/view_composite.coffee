((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./view_component', './list'], factory
    return
  else if typeof exports is 'object'
    ViewComponent = require './view_component'
    List = require './list'
    module.exports = factory(ViewComponent, List)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    ViewComponent = root.Mimosas.ViewComponent
    List = root.Mimosas.List
    root.Mimosas.ViewComposite = factory(ViewComponent, List)
    return
) @, (ViewComponent, List) ->
  
  class ViewComposite extends ViewComponent
    constructor: () ->
      super
      @list = new List()
      
    add: (component) ->
      component.setParent @
      @list.append component
      
    remove: (pointer) ->
      @list.remove pointer
      
    getViewComposite: () ->
      @
      
  ViewComposite

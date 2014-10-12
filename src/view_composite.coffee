{ViewComponent} = require './view_component'
{List} = require './list'
{Iterator} = require './iterator'

class ViewComposite extends ViewComponent
  constructor: () ->
    super
    @list = new List()
    @superView = undefined
    
    if @defaultControllerClass?
      @setController new @defaultControllerClass()

  addSubView: (component) ->
    component.superView = @
    @add component

  add: (component) ->
    component.superView = @
    @list.append component

  remove: (pointer) ->
    @list.remove pointer

  display: ->
    super
    @displaySubViews()

  displaySubViews: ->
    i = new Mimosas.Iterator @list
    until i.isDone()
      subView = i.currentItem()
      subView.display()
      i.next()
      
  hide: ->
    super
    @hideSubViews()

  hideSubViews: ->
    i = new Iterator @list
    until i.isDone()
      subView = i.currentItem()
      subView.hide()
      i.next()

  release: ->
    @releaseSubViews()
    super

  releaseSubViews: ->
    i = new Iterator @list
    until i.isDone()
      subView = i.currentItem()
      subView.release()
      i.next()
    @list.removeAll()

exports.ViewComposite = ViewComposite

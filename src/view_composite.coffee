{ViewComponent} = require './view_component'
{List} = require './list'
{Iterator} = require './iterator'

class ViewComposite extends ViewComponent
  constructor: () ->
    super
    @list = new List()
    @superView = undefined

  addSubView: ->
    @add.apply @, arguments

  add: (component) ->
    component.superView = @
    @list.append component

  remove: (pointer) ->
    @list.remove pointer

  display: () ->
    @dsiplayView()
    @displaySubViews()

  displayView: ->

  displaySubViews: ->
    i = new Iterator @list
    until i.isDone()
      subView = i.currentItem()
      subView.display()
      i.next()

exports.ViewComposite = ViewComposite

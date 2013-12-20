
class Iterator
  constructor: (@list) ->
    @current = 0
  first: () ->
    @current = 0
    @
  next: () ->
    @current += 1
    @
  isDone: () ->
    @current >= @list.count()
  currentItem: () ->
    throw new Error "IteratorOutOfBounds" if @isDone()
    @list.getByIndex @current

class List
  constructor: () ->
    @pointers = []
    @items = {}

  count: () ->
    @pointers.length

  get: (pointer) ->
    @items[pointer]

  getByIndex: (index) ->
    throw new Error 'ArrayOutOfBoundsException' if index >= @count()
    throw new Error 'ArrayOutOfBoundsException' if index < 0
    @items[@pointers[index]]

  first: () ->
    @items[@pointers[0]]

  last: () ->
    @items[@pointers[@pointers.length - 1]]

  append: (item) ->
    throw new Error 'NullPointerException' unless item.__POINTER__?
    pointer = item.__POINTER__
    @pointers.push pointer
    @items[pointer] = item

  remove: (pointer) ->
    throw new Error 'ArgumentException' unless pointer?
    throw new Error 'ListItemUndefined' unless items[pointer]?

    index = -1
    for item, i in @pointers
      if item is pointer
        index = i
        break

    throw new Error 'ListItemUndefined' if index is -1

    delete @items[pointer]
    @pointers.splice index, 1

  removeLast: () ->
    item = @last()
    @remove item.__POINTER__

  removeFirst: () ->
    item = @first()
    @remove item.__POINTER__

  removeAll: () ->
    @pointers = []
    @items = {}

class GUID
  @generate: () ->
    S4 = () ->
      (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
    "#{S4()}#{S4()}-#{S4()}-#{S4()}-#{S4()}-#{S4()}#{S4()}#{S4()}"


class DependentsCollection extends List

class Controller
  constructor: () ->
  addModel: (@model) ->
  addView: (@view) ->
  releaseView: () ->
    @view = undefined


# Component
class BaseView
  constructor: () ->
    @__POINTER__ =  GUID.generate()

  update: (model) ->
  release: () ->

  addModelController: (model, controller) ->
    @addModel model
    @addController controller

  addModel: (@model) ->
    @model.addView @

  addController: (@controller) ->
    @controller.addView @
    
  setElement: (selector) ->
    @element = $(selector)
    
  getElement: () ->
    @element

# Observer and Leaf
class View extends BaseView
  update: (model) ->
    @display model

  release: () ->
    @model.releaseView @
    @controller.releaseView @
    @releaseSubViews()

# Observer and Composite
class CompositeView extends BaseView
  constructor: () ->
    super
    @subViews = new List()
    @subViewIterator = new Iterator @subViews

  update: (@model) ->
    @subViewIterator.first()
    while not @subViewIterator.isDone()
      @subViewIterator.currentItem().update @model
      @subViewIterator.next()
    return

  release: () ->
    @subViewIterator.first()
    while not @subViewIterator.isDone()
      @subViewIterator.currentItem().release()
      @subViewIterator.next()
    return

  display: () ->
    @subViewIterator.first()
    while not @subViewIterator.isDone()
      @subViewIterator.currentItem().display()
      @subViewIterator.next()
    return

  addSubView: (subView) ->
    # subView = new SubView()
    # subView.addModel @model
    # subView.addController @controller
    @subViews.append subView

# Subject
class Model
  constructor: () ->
    # observers
    @dependents = new DependentsCollection()

  # attach
  addView: (view) ->
    @dependents.append view

  # detach
  releaseView: (view) ->
    @dependents.remove view

  # notify
  changed: () ->
    i = new Iterator @dependents
    while not i.isDone()
      i.currentItem().update @
      i.next()


class TodoModel extends Model
  getDesc: () -> @desc
  setDesc: (@desc) ->
    @changed()
  isDone: () -> @done
  setDone: (@done) ->
    @changed()

class TodoItemCtrl extends Controller
  addView: (@view) ->
    # @view.element.on 'changed', 'input[type=checkbox]', (e) =>
    #  @model.setDone $(e.target).prop 'checked'

class TodoItemView extends View
  constructor: () ->
    super
    @element = undefined

  update: () ->
    @display()

  display: () ->
    html = """
			<li>
				<div class="view">
					<input class="toggle" type="checkbox">
					<label>#{@model.getDesc()}</label>
					<button class="destroy"></button>
				</div>
				<input class="edit" value="#{@model.getDesc()}">
			</li>
    """
    @element = $(html)
    $('#todo-list').append @element

class NewTodoItemCtrl extends Controller
  addView: (@view) ->
    @view.getElement().on 'keypress', (e) =>
      keycode = e.keyCode or e.which
      if keycode.toString() is '13'
        alert $(e.target).val()

class NewTodoItemView extends View
  constuctor: () ->
    super
  update: () ->
    @display()

class TodoCtrl extends Controller
  init: () ->
    
    newTodoItemView = new NewTodoItemView()
    newTodoItemView.setElement '#new-todo'
    newTodoItemCtrl = new NewTodoItemCtrl()
    newTodoItemView.addController newTodoItemCtrl
    @view.addSubView newTodoItemView
    
    todos = ['Get groceries', 'Take out trash', 'Mow the lawn']
    for todo in todos
      todoModel = new TodoModel()
      todoItemCtrl = new TodoItemCtrl()
      todoItemCtrl.addModel todoModel
      todoItemView = new TodoItemView()
      todoItemView.addModel todoModel
      todoItemView.addController todoItemCtrl
      @view.addSubView todoItemView

      todoModel.setDesc todo

class TodoView extends CompositeView

$ () ->
  todoCtrl = new TodoCtrl()
  todoView = new TodoView()
  todoView.addController todoCtrl
  todoView.controller.init()
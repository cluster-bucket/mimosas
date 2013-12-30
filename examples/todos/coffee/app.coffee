define [
  'cs!collections/todos'
  'cs!views/page'
  'cs!views/new'
  'cs!views/list'
  'cs!controllers/new'
  'cs!controllers/list'
], (Todos, PageView, NewTodoView, ListTodosView, NewTodoController, ListTodosController) ->

  todos = new Todos()

  newTodoCtrl = new NewTodoController()
  newTodoCtrl.addEvent 'keypress', '#new-todo', 'inputChanged'

  newTodoView = new NewTodoView '#new-todo'
  newTodoView.setController newTodoCtrl
  newTodoView.setModel todos

  listTodosCtrl = new ListTodosController()
  listTodosCtrl.addEvent 'click', '.destroy', 'destroyClicked'
  listTodosCtrl.addEvent 'click', '.toggle', 'toggleClicked'

  listTodosView = new ListTodosView '#todo-list'
  listTodosView.setController listTodosCtrl
  listTodosView.setModel todos

  pageView = new PageView '#todoapp'
  pageView.add newTodoView
  pageView.add listTodosView
  pageView.display()

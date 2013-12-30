define [
  'cs!models/todos'
  'cs!views/top'
  'cs!views/new'
  'cs!views/list'
  'cs!views/toggle'
  'cs!controllers/new'
  'cs!controllers/list'
  'cs!controllers/toggle'
], (Todos, TopView, NewTodoView, ListTodosView, ToggleTodosView,
  NewTodoController, ListTodosController, ToggleTodosController) ->

  todos = new Todos()

  newTodoView = new NewTodoView '#new-todo'
  newTodoView.setModel todos
  newTodoView.setController new NewTodoController()
  newTodoView.addEvent 'keypress', '#new-todo', 'inputChanged'

  toggleTodosView = new ToggleTodosView '#toggle-all'
  toggleTodosView.setModel todos
  toggleTodosView.setController new ToggleTodosController()
  toggleTodosView.addEvent 'click', '#toggle-all', 'toggleAllClicked'

  listTodosView = new ListTodosView '#todo-list'
  listTodosView.setModel todos
  listTodosView.setController new ListTodosController()
  listTodosView.addEvent 'click', '.destroy', 'destroyClicked'
  listTodosView.addEvent 'click', '.toggle', 'toggleClicked'

  topView = new TopView '#todoapp'
  topView.add newTodoView
  topView.add listTodosView
  topView.display()

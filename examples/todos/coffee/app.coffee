define [
  'cs!models/todos'
  'cs!views/top'
  'cs!views/new'
  'cs!views/list'
  'cs!views/footer'
  'cs!controllers/new'
  'cs!controllers/list'
  'cs!controllers/footer'
], (Todos, TopView, NewTodoView, ListTodosView, FooterView,
  NewTodoController, ListTodosController, FooterController) ->

  todos = new Todos()

  newTodoView = new NewTodoView '#new-todo'
  newTodoView.setModel todos
  newTodoView.setController new NewTodoController()
  newTodoView.addEvent 'keypress', '#new-todo', 'inputChanged'

  listTodosView = new ListTodosView '#main'
  listTodosView.setModel todos
  listTodosView.setController new ListTodosController()
  listTodosView.addEvent 'click', '.destroy', 'destroyClicked'
  listTodosView.addEvent 'click', '.toggle', 'toggleClicked'
  listTodosView.addEvent 'click', '#toggle-all', 'toggleAllClicked'

  footerView = new FooterView '#footer'
  footerView.setModel todos
  footerView.setController new FooterController()

  topView = new TopView '#todoapp'
  topView.add newTodoView
  topView.add listTodosView
  topView.add footerView
  topView.display()

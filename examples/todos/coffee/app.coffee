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

  newTodoElement = document.getElementById 'new-todo'
  newTodoView = new NewTodoView newTodoElement
  newTodoView.setModel todos
  newTodoView.setController new NewTodoController()
  newTodoView.addEvent 'keypress', 'inputChanged', '#new-todo'

  listTodosElement = document.getElementById 'main'
  listTodosView = new ListTodosView listTodosElement
  listTodosView.setModel todos
  listTodosView.setController new ListTodosController()
  listTodosView.addEvent 'click', 'destroyClicked', '.destroy'
  listTodosView.addEvent 'click', 'toggleClicked', '.toggle'
  listTodosView.addEvent 'click', 'toggleAllClicked', '#toggle-all'

  footerElement = document.getElementById 'footer'
  footerView = new FooterView footerElement
  footerView.setModel todos
  footerView.setController new FooterController()

  topElement = document.getElementById 'todoapp'
  topView = new TopView topElement
  topView.add newTodoView
  topView.add listTodosView
  topView.add footerView
  topView.display()

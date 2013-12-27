define [
  'cs!collections/todos'
  'cs!views/page'
  'cs!views/new'
  'cs!views/list'
  'cs!controllers/new'
  'cs!controllers/list'
], (Todos, PageView, NewTodoView, ListTodosView, NewTodoController, ListTodosController) ->

  todos = new Todos()

  pageView = new PageView '#todoapp'
  
  newTodoView = new NewTodoView '#new-todo'
  newTodoView.setController new NewTodoController()
  newTodoView.setModel todos
  
  listTodosView = new ListTodosView '#todo-list'
  listTodosView.setController new ListTodosController()
  listTodosView.setModel todos

  pageView.add newTodoView
  pageView.add listTodosView
  pageView.display()
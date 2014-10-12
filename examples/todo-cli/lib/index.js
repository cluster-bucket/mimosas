#!/usr/bin/env node

var commander = require('commander');

commander.version('0.1.0');

commander
  .command('create <todo>')
  .description('Create a new todo');

commander
  .command('list')
  .description('List all todos');

var Todos = require('./models/todos').Todos;
var NewTodoView = require('./views/new').NewTodoView;
var NewTodoController = require('./controllers/new').NewTodoController;
var ListTodosView = require('./views/list').ListTodosView;
var ListTodosController = require('./controllers/list').ListTodosController;

var todos = new Todos();

var newTodoView = new NewTodoView(commander);
newTodoView.setModel(todos);
newTodoView.setController(new NewTodoController());
newTodoView.addEvent('create', 'inputChanged');

var listTodosView = new ListTodosView(commander);
listTodosView.setModel(todos);
listTodosView.setController(new ListTodosController());
listTodosView.addEvent('list', 'list');

commander.parse(process.argv);



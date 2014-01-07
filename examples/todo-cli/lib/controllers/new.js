var Mimosas = require('../../../../mimosas');
var Todo = require('../models/todo').Todo;

var NewTodoController = (function(classToExtend) {
  Mimosas.Class.extends(NewTodoController, classToExtend);

  function NewTodoController() {}

  NewTodoController.prototype.inputChanged = function (title) {
    var todo;

    todo = new Todo({
      title: title
    });

    this.getModel().append(todo);
  }

  return NewTodoController;

})(Mimosas.ControllerStrategy);

exports.NewTodoController = NewTodoController;

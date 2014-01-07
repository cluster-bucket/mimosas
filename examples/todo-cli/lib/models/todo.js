var Mimosas = require('../../../../mimosas');
var fs = require('fs');

var Todo = (function(classToExtend) {
  Mimosas.Class.extends(Todo, classToExtend);

  function Todo(data) {
    Todo.__super__.constructor.apply(this, arguments);

    this.__POINTER__ = Mimosas.Guid.generate();

    if (data.title) {
      this.setTitle(data.title);
    }
  }

  Todo.prototype.getTitle = function() {
    return this.title;
  };

  Todo.prototype.setTitle = function(title) {
    this.title = title;
  };

  return Todo;

})(Mimosas.ModelSubject);

exports.Todo = Todo;

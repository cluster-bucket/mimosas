var Mimosas = require('../../../../mimosas');
var Todo = require('./todo').Todo;
var fs = require('fs');

var Todos = (function(_super) {
  Mimosas.Class.extends(Todos, _super);

  function Todos() {
    Todos.__super__.constructor.apply(this, arguments);
    this.collection = new Mimosas.List();
    this.loadTodosFromFile();
  }

  Todos.prototype.append = function(item) {
    var self = this;
    var append;

    if (!item) {
      throw new ReferenceError('item');
    }

    this.collection.append(item);

    append = '' + item.getTitle() + "\n";

    fs.appendFile('todos.txt', append, function () {
      self.notify();
    });
  };

  Todos.prototype.remove = function(pointer) {
    this.collection.remove(pointer);
    return this.notify();
  };

  Todos.prototype.get = function(pointer) {
    return this.collection.get(pointer);
  };

  Todos.prototype.count = function() {
    return this.collection.count();
  };

  Todos.prototype.getIterator = function() {
    return new Mimosas.Iterator(this.collection);
  };

  Todos.prototype.loadTodosFromFile = function () {
    var file, todos, i, len, title, todo;

    if (!fs.existsSync('todos.txt')) {
      return;
    }

    file = fs.readFileSync('todos.txt').toString();
    todos = file.split('\n');

    for (i = 0, len = todos.length; i < len; i += 1) {
      title = todos[i];
      if (!title) {
        continue;
      }
      todo = new Todo({title: title});
      this.collection.append(todo);
    }
  };

  return Todos;

})(Mimosas.ModelSubject);

exports.Todos = Todos;

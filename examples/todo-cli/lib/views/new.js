var Mimosas = require('../../../../mimosas');

var NewTodoView = (function(_super) {
  Mimosas.Class.extends(NewTodoView, _super);

  function NewTodoView() {
    NewTodoView.__super__.constructor.apply(this, arguments);
  }

  NewTodoView.prototype.changed = function (err) {
    this.display();
  };

  NewTodoView.prototype.display = function () {
    console.log("New todo added");
  };

  return NewTodoView;

})(Mimosas.ViewLeaf);

exports.NewTodoView = NewTodoView;

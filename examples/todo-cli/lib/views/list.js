var Mimosas = require('../../../../mimosas');

var ListTodosView = (function(_super) {
  Mimosas.Class.extends(ListTodosView, _super);

  function ListTodosView() {
    ListTodosView.__super__.constructor.apply(this, arguments);
  }

  ListTodosView.prototype.changed = function () {
    // Do nothing
  };

  ListTodosView.prototype.display = function () {
    var i, title;

    i = this.getModel().getIterator();
    while (!i.isDone()) {
      title = i.currentItem().getTitle()
      console.log(title);
      i.next();
    }
  };

  return ListTodosView;

})(Mimosas.ViewLeaf);

exports.ListTodosView = ListTodosView;

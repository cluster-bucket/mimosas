var Mimosas = require('../../../../mimosas');

var ListTodosController = (function(classToExtend) {
  Mimosas.Class.extends(ListTodosController, classToExtend);

  function ListTodosController() {}

  ListTodosController.prototype.list = function () {
    this.getView().display();
  };

  return ListTodosController;

})(Mimosas.ControllerStrategy);

exports.ListTodosController = ListTodosController;

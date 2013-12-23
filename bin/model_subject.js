// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    var Iterator, List;
    if (typeof define === 'function' && define.amd) {
      define(['./list', './iterator'], factory);
    } else if (typeof exports === 'object') {
      List = require('./list');
      Iterator = require('./iterator');
      module.exports = factory(List, Iterator);
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      List = root.Mimosas.List;
      Iterator = root.Mimosas.Iterator;
      root.Mimosas.ModelSubject = factory(List, Iterator);
    }
  })(this, function(List, Iterator) {
    var ModelSubject;
    ModelSubject = (function() {
      function ModelSubject() {
        this.observers = new List();
      }

      ModelSubject.prototype.attach = function(obj) {
        return this.observers.append(obj);
      };

      ModelSubject.prototype.detach = function(observer) {
        return this.observers.remove(observer);
      };

      ModelSubject.prototype.notify = function() {
        var i, _results;
        i = new Iterator(this.observers);
        _results = [];
        while (!i.isDone()) {
          i.currentItem().changed(this);
          _results.push(i.next());
        }
        return _results;
      };

      return ModelSubject;

    })();
    return ModelSubject;
  });

}).call(this);
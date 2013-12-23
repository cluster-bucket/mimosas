// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    if (typeof define === 'function' && define.amd) {
      define(['iterator'], factory);
    } else if (typeof exports === 'object') {
      module.exports = factory(require('iterator'));
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      root.Mimosas.Aggregate = factory(root.Mimosas.Iterator);
    }
  })(this, function(Iterator) {
    var Aggregate;
    Aggregate = (function() {
      function Aggregate() {}

      Aggregate.prototype.createIterator = function(items) {
        var key, list, val;
        list = new List();
        for (key in items) {
          val = items[key];
          val.__POINTER__ = key;
          list.append(val);
        }
        return new Iterator(list);
      };

      return Aggregate;

    })();
    return Aggregate;
  });

}).call(this);

(function() {
  (function(root, factory) {
    if (typeof define === 'function' && define.amd) {
      return define(['iterator'], factory);
    } else if (typeof exports === 'object') {
      return module.exports = factory(require('iterator'));
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      return root.Mimosas.Aggregate = factory(root.Mimosas.Iterator);
    }
  })(this, function(Iterator) {
    var Aggregate;
    return Aggregate = (function() {
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
  });

}).call(this);

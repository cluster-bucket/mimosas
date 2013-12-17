(function() {
  (function(root, factory) {
    if (typeof define === 'function' && define.amd) {
      return define(factory);
    } else if (typeof exports === 'object') {
      return module.exports = factory();
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      return root.Mimosas.Iterator = factory();
    }
  })(this, function() {
    var Iterator;
    return Iterator = (function() {
      function Iterator(list) {
        this.list = list;
        this.current = 0;
      }

      Iterator.prototype.first = function() {
        this.current = 0;
        return this;
      };

      Iterator.prototype.next = function() {
        this.current += 1;
        return this;
      };

      Iterator.prototype.isDone = function() {
        return this.current >= this.list.count();
      };

      Iterator.prototype.currentItem = function() {
        if (this.isDone()) {
          throw new Error("IteratorOutOfBounds");
        }
        return this.list.getByIndex(this.current);
      };

      return Iterator;

    })();
  });

}).call(this);

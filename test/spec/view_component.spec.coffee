((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/view_component', '../../bin/view_observer'], factory
    return
  else if typeof exports is 'object'
    ViewComponent = require '../../src/view_component.coffee'
    ViewObserver = require '../../src/view_observer.coffee'
    module.exports = factory ViewComponent, ViewObserver
    return
  else
    ViewComponent = root.Mimosas.ViewComponent
    ViewObserver = root.Mimosas.ViewObserver
    factory ViewComponent, ViewObserver
    return
) @, (ViewComponent, ViewObserver) ->

  describe 'ViewComponent', ->

    component = undefined

    beforeEach ->
      component = new ViewComponent('#fixture')

    afterEach ->
      component = undefined

    it 'should exist', ->
      expect(ViewComponent).to.exist

    it 'should throw if a selector is not passed to the constructor', ->
      throwMe = -> new ViewComponent()
      expect(throwMe).to.throw()

    it 'should throw if selector doesn\'t resolve to an element', ->
      throwMe = -> new ViewComponent('#foo')
      expect(throwMe).to.throw()

    it 'should create an element instance variable when instantiated with a valid selector', ->
      expect(component.element).to.exist

    it 'should create the default controller when instantiated', ->
      expect(component.controller).to.exist

    it 'should get an element from a selector, scoped to the instances current element', ->
      component = new ViewComponent 'body'
      element = component.getElementFromSelector '#fixture'
      expect(element).to.exist

    it 'should not get an element from a selector if it is out of scope', ->
      element = component.getElementFromSelector 'body'
      expect(element).not.to.exist

    it 'should set a model', ->
      expect(component.model).not.to.exist
      model =
        attach: () ->
        foo: 'bar'
      component.setModel model
      expect(component.model).to.exist
      expect(component.model.foo).to.exist

    it 'should call attach on the model when it is set', ->
      modelAttached = false
      model =
        attach: () ->
          modelAttached = true
      component.setModel model
      expect(modelAttached).to.be.true

    it 'should set the model on the controller when the model is set', ->
      modelSet = false
      model = attach: () ->
      component.controller =
        setModel: () ->
          modelSet = true
      component.setModel model
      expect(modelSet).to.be.true

    it 'should set a non-default controller', ->
      controller =
        setView: () ->
        foo: 'bar'
      component.setController controller
      expect(component.controller.strategy).to.exist
      expect(component.controller.strategy.foo).to.exist

    it 'should set the view on the controller when it is set', ->
      viewSet = false
      controller =
        setView: () ->
          viewSet = true
      component.setController controller
      expect(viewSet).to.be.true

    it 'should set the model on the controller when it is set', ->
      modelSet = false
      model = attach: () ->
      controller =
        setView: () ->
        setModel: () ->
          modelSet = true
      component.setModel model
      component.setController controller
      expect(modelSet).to.be.true

    it 'should add an event and call triggerEvent when it is dispatched', ->
      eventTriggered = false
      controller =
        setView: () ->
        setModel: () ->
      component.triggerEvent = () ->
        eventTriggered = true
      component.addEvent 'click', '#fixture', 'foo'
      component.element.click()
      expect(eventTriggered).to.be.true

    it 'should call a method on the controller', ->
      fooCalled = false
      controller =
        setView: () ->
        setModel: () ->
        foo: () ->
          fooCalled = true
      component.setController controller
      component.addEvent 'click', '#fixture', 'foo'
      component.element.click()
      expect(fooCalled).to.be.true

    it 'should return true when an element matches a selector', ->
      element = component.element
      selector = '#fixture'
      result = component.elementMatchesSelector element, selector
      expect(result).to.be.true

    it 'should return false when an element doesn\'t match a selector', ->
      element = component.element
      selector = '#xfixture'
      result = component.elementMatchesSelector element, selector
      expect(result).to.be.false

    it 'should get the closest element to a given element, with a given selector', ->
      child = document.getElementById 'fixture-child'
      result = component.closest child, '#fixture'
      expect(result.id).to.equal 'fixture'

helper = require '../util/helper'

class Page
  _el    : null
  _index : null
  _isEven : null
  
  constructor : (@_el) ->

  setIndex    : (@_index) ->
    @_isEven = @_index % 2 is 0
    console.log 'setting index to ', @_index, @_index % 2, @_isEven
    helper.addClass @_el, "face-#{@_index}"

  show : ->
    @_el.style.display = 'block'
  
  hide:  ->
    @_el.style.display = 'none'
    
  appendTo : (targetEl) ->
    @_movePage targetEl

  isEven : ->
    @_isEven
    
  _movePage : (targetEl) ->
    targetEl.appendChild @_el

module.exports = Page
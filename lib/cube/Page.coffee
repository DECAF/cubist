class Page
  el : null

  constructor : (@el) ->
    
  show: (targetEl) ->
    @_movePage targetEl

  hide: (targetEl) ->
    @_movePage targetEl

  _movePage: (targetEl) ->
    targetEl.appendChild @el
    
module.exports = Page
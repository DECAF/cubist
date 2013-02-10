Page = require './Page'

class ContentController
  _current     : -1
  _cube        : null
  _siding      : null
  _pages       : null
  _frontSideEl : null
  _backSideEl  : null

  constructor : (@_cube) ->
    @_pages = []
    @_siding = document.createElement 'div'
    @_frontSideEl = @_cube.querySelector ".#{ContentController.CSS_CLASS_FRONT}"
    @_backSideEl = @_cube.querySelector ".#{ContentController.CCS_CLASS_BACK}"

  setPages : (pages) ->
    @_addPage page for page in pages

  _addPage      : (pageEl) ->
    page = new Page pageEl
    @_pages.push page
    
    page.setIndex @size() - 1
    page.appendTo if page.isEven() then @_frontSideEl else @_backSideEl  
    page.hide()
    
  showPage: (index) ->
    page = @_pages[index]
    page.show() unless page is undefined

  hidePage : (index) ->
    @_pages[index]?.hide()

  _gotoPage : (index, face) ->
    page = @_pages[index]
    unless page is undefined
      @_current = index
      page.show face

  size : ->
    @_pages.length

ContentController.SIDING_CLASS_APPENDIX = '-siding'
ContentController.CSS_CLASS_FRONT       = 'cubist-face-front'
ContentController.CCS_CLASS_BACK        = 'cubist-face-back'

module.exports = ContentController
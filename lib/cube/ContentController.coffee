Page = require './Page'
PageCollection = require './PageCollection'

class ContentController
  _current        : -1
  _cube           : null
  _pageCollection : null
  _siding         : null
  _frontSideEl    : null
  _backSideEl     : null

  constructor : (@_cube) ->
    @_pageCollection = new PageCollection()
    @_siding = document.createElement 'div'
    @_frontSideEl = @_cube.querySelector ".#{ContentController.CSS_CLASS_FRONT}"
    @_backSideEl = @_cube.querySelector ".#{ContentController.CCS_CLASS_BACK}"

  setPages : (pages) ->
    @_addPage page for page in pages

  _addPage : (pageEl) ->
    page = new Page pageEl
    index = @_pageCollection.addItem page
    page.setIndex index
    page.appendTo if page.isEven() then @_frontSideEl else @_backSideEl
    page.hide()

  showPage : (index) ->
    page = @_pageCollection.getItem index
    page.show() unless page is null

  hidePage : (index) ->
    page = @_pageCollection.getItem index
    page.hide()

  getDistance : (index) ->
    @_pageCollection.getDistance @_pageCollection.getIndex(), index

  _gotoPage : (index, face) ->
    page = @_pages[index]
    unless page is undefined
      @_current = index
      page.show face

  size : ->
    @_pageCollection.size()

ContentController.SIDING_CLASS_APPENDIX = '-siding'
ContentController.CSS_CLASS_FRONT       = 'cubist-face-front'
ContentController.CCS_CLASS_BACK        = 'cubist-face-back'

module.exports = ContentController
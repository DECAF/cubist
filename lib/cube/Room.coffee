Page     = require './Page'
cubeHtml = require "./html/cubeSides"

class Room
  _current     : -1
  _el          : null
  _cube        : null
  _siding      : null
  _pages       : null
  _frontSideEl : null
  _backSideEl  : null

  constructor : (@_el) ->
    @_cube = document.createElement 'div'
    @_siding = document.createElement 'div'
    @_pages = []

  create : (containerClass) ->
    @_cube.className = containerClass
    @_siding.className = containerClass + Room.SIDING_CLASS_APPENDIX

    @_createCubeHtml()

    @_el.appendChild @_cube

  _createCubeHtml : () ->
    @_cube.innerHTML = cubeHtml
    @_frontSideEl = @_cube.querySelector ".#{Room.CSS_CLASS_FRONT}"
    @_backSideEl = @_cube.querySelector ".#{Room.CCS_CLASS_BACK}"

  findPages : (pageSelector) ->
    pages = @_el.querySelectorAll pageSelector
    @_addPage page for page in pages

  _addPage : (pageEl) ->
    page = new Page pageEl
    @_pages.push page
    @_hidePage @size() - 1

  _hidePage : (index) ->
    @_pages[index]?.hide @_siding

  _init3D : ->
    n = (a) ->
      c = b.width()
      d = a ? "" + c * 60 / 100 + "px" : "0",
      b.css({"-webkit-perspective" : d, "-moz-perspective" : d, "-ms-perspective" : d, "-o-perspective" : d, perspective : d})

  showFrontPage : (index, callback) ->
    @_gotoPage index, @_frontSideEl unless index is @_current
      
  showBackPage  : (index, callback) ->
    @_gotoPage index, @_backSideEl unless index is @_current

  _gotoPage: (index, face) ->
    page = @_pages[index]
    unless page is undefined
      @_current = index
      page.show face
      
  size          : ->
    @_pages.length

Room.SIDING_CLASS_APPENDIX = '-siding'
Room.CSS_CLASS_FRONT       = 'cubist-face-front'
Room.CCS_CLASS_BACK        = 'cubist-face-back'

module.exports = Room
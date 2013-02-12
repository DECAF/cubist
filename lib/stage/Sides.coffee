CubistExpception = require '../util/CubistException'
helper           = require '../util/helper'
class Sides
  _cubeEl              : null
  _isRotatedVertically : null
  _sides               : null

  constructor : (@_cubeEl, @_isRotatedVertically) ->
    selectors = if @_isRotatedVertically then Sides.VERTICAL_SIDES else Sides.HORIZONTAL_SIDES
    @_sides = (@_cubeEl.querySelector(".#{selector}") for selector in selectors)

  addPages    : (pageElements) ->
    throw new CubistExpception "A cube supports up to 4 different pages, not more." if pageElements.length > Sides.MAX_PAGES        
    @_addPage page, index for page,index in pageElements

  _addPage : (pageEl, index) ->
    @_sides[index].appendChild(pageEl)
    helper.addClass pageEl, Sides.PAGE_ITEM_PREFIX + index
    ###page = new Page pageEl
    index = @_pageCollection.addItem page
    page.setIndex index
    page.appendTo if page.isEven() then @_frontSideEl else @_backSideEl
    page.hide()###

  updateSideSizes: (stageWidth, stageHeight)->
    

Sides.MAX_PAGES        = 4
Sides.PAGE_ITEM_PREFIX = 'page-'
Sides.CSS_CLASS_FRONT  = 'cubist-face-front'
Sides.CSS_CLASS_BACK   = 'cubist-face-back'
Sides.CSS_CLASS_RIGHT  = 'cubist-face-right'
Sides.CSS_CLASS_LEFT   = 'cubist-face-left'
Sides.CSS_CLASS_TOP    = 'cubist-face-top'
Sides.CSS_CLASS_BOTTOM = 'cubist-face-bottom'
Sides.VERTICAL_SIDES   = [Sides.CSS_CLASS_FRONT, Sides.CSS_CLASS_TOP, Sides.CSS_CLASS_BACK, Sides.CSS_CLASS_BOTTOM]
Sides.HORIZONTAL_SIDES = [Sides.CSS_CLASS_FRONT, Sides.CSS_CLASS_RIGHT, Sides.CSS_CLASS_BACK, Sides.CSS_CLASS_LEFT]


module.exports = Sides
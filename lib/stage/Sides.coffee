CubistExpception = require '../util/CubistException'
helper           = require '../util/helper'
class Sides
  _cubeEl              : null
  _isRotatedVertically : null
  _sides               : null
  _pageSides           : null

  constructor : (@_cubeEl, @_isRotatedVertically) ->
    @_pageSides = if @_isRotatedVertically then Sides.VERTICAL_SIDES else Sides.HORIZONTAL_SIDES
    #@_sides = (@_cubeEl.querySelector(".#{selector}") for selector in selectors)
    @_sides = {}
    for selector in Sides.ALL_SIDES
      @_sides[selector] = @_cubeEl.querySelector(".#{selector}")

    console.dir @_sides

  resizeSides: (width, height)->
    if @_isRotatedVertically
      console.log 'vertical'
      $(@_sides[Sides.CSS_CLASS_FRONT]).css
        transform: "translateZ(#{height / 2}px)" 
        
      $(@_sides[Sides.CSS_CLASS_BACK]).css
        transform: "rotateX(180deg) translateZ(#{height / 2}px)"

      $(@_sides[Sides.CSS_CLASS_RIGHT]).css
        transform: "rotateY(90deg) translateZ(#{width - height / 2}px)"
        width: height
        
      $(@_sides[Sides.CSS_CLASS_LEFT]).css
        transform: "rotateY(-90deg) translateZ(#{height / 2}px)"
        width: height

      $(@_sides[Sides.CSS_CLASS_TOP]).css
        transform: "rotateX(90deg) translateZ(#{height / 2}px)"
        
      $(@_sides[Sides.CSS_CLASS_BOTTOM]).css
        transform: "rotateX( -90deg ) translateZ(#{height / 2}px)"
    else
      console.log 'horizontal'
      $(@_sides[Sides.CSS_CLASS_FRONT]).css
        transform: "translateZ(#{width / 2}px)"

      $(@_sides[Sides.CSS_CLASS_BACK]).css
        transform: "rotateY(180deg) translateZ(#{width / 2}px)"

      $(@_sides[Sides.CSS_CLASS_RIGHT]).css
        transform: "rotateY(90deg) translateZ(#{width / 2}px)"

      $(@_sides[Sides.CSS_CLASS_LEFT]).css
        transform: "rotateY(-90deg) translateZ(#{width / 2}px)"

      $(@_sides[Sides.CSS_CLASS_TOP]).css
        transform: "rotateX(90deg) translateZ(#{width / 2}px)"
        height: width

      $(@_sides[Sides.CSS_CLASS_BOTTOM]).css
        transform: "rotateX( -90deg ) translateZ(#{height - width / 2}px)"
        height: width


  addPages    : (pageElements) ->
    throw new CubistExpception "A cube supports up to 4 different pages, not more." if pageElements.length > Sides.MAX_PAGES        
    @_addPage page, index for page,index in pageElements

  _addPage : (pageEl, index) ->
    @_sides[@_pageSides[index]].appendChild(pageEl)
    helper.addClass pageEl, Sides.PAGE_ITEM_PREFIX + index

  updateSideSizes: (stageWidth, stageHeight)->
    

Sides.MAX_PAGES        = 4
Sides.PAGE_ITEM_PREFIX = 'page-'
Sides.CSS_CLASS_FRONT  = 'cubist-face-front'
Sides.CSS_CLASS_BACK   = 'cubist-face-back'
Sides.CSS_CLASS_RIGHT  = 'cubist-face-right'
Sides.CSS_CLASS_LEFT   = 'cubist-face-left'
Sides.CSS_CLASS_TOP    = 'cubist-face-top'
Sides.CSS_CLASS_BOTTOM = 'cubist-face-bottom'
Sides.ALL_SIDES        = [Sides.CSS_CLASS_FRONT, Sides.CSS_CLASS_BACK, Sides.CSS_CLASS_RIGHT,Sides.CSS_CLASS_LEFT, Sides.CSS_CLASS_TOP, Sides.CSS_CLASS_BOTTOM]
Sides.VERTICAL_SIDES   = [Sides.CSS_CLASS_FRONT, Sides.CSS_CLASS_TOP, Sides.CSS_CLASS_BACK, Sides.CSS_CLASS_BOTTOM]
Sides.HORIZONTAL_SIDES = [Sides.CSS_CLASS_FRONT, Sides.CSS_CLASS_RIGHT, Sides.CSS_CLASS_BACK, Sides.CSS_CLASS_LEFT]


module.exports = Sides
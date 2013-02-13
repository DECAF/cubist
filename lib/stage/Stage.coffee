CubistOptions    = require '../config/CubistOptions'
Animator         = require './Animator'
Sides            = require './Sides'
cubeHtml         = require "../cube/html/cubeSides"
helper           = require '../util/helper'

class Stage
  pageCount                : 0
  _stage                   : null
  _options                 : null
  _cubeEl                  : null
  _animator                : null
  _sides                   : null
  _stageWidth              : 0
  _stageHeight             : 0
  

  constructor : (@_stage, @_options) ->
    isVertical = @_options.get(CubistOptions.IS_ROTATED_VERTICALLY)
    orientationClass = if isVertical then Stage.CSS_CLASS_VERTICAL else Stage.CSS_CLASS_HORIZONTAL
      
    helper.addClass @_stage, @_options.get(CubistOptions.CSS_CLASS_STAGE)
    helper.addClass @_stage, orientationClass 

    @_cubeEl = document.createElement 'div'
    @_cubeEl.className = @_options.get(CubistOptions.CSS_CLASS_CUBE)
    @_cubeEl.innerHTML = cubeHtml
    @_stage.appendChild @_cubeEl

    @_animator = new Animator @_stage, @_cubeEl, isVertical
    @_sides = new Sides @_cubeEl, isVertical
    
    @_bindEvents()
    @_draw()

  _bindEvents : ->
    $(window).on "resize.cubist-#{helper.uid()}", =>
      @_onResize()

  _onResize : ->
    # rechts und unten berechnen
    @_draw()

  _draw : ->
    @_calculateSizes()
    @_resizeFaces()

  _calculateSizes : ->
    @_stageWidth = @_stage.offsetWidth
    @_stageHeight = @_stage.offsetHeight

  _resizeFaces : ->
    @_animator.resizeCube(@_stageWidth, @_stageHeight)
    @_sides.resizeSides(@_stageWidth, @_stageHeight)

  getCubeEl : ->
    @_cubeEl

  getSideElements: ->
     
    
  addPages : (selector) ->
    pageElements = @_stage.querySelectorAll selector
    @pageCount += pageElements.length    
    @_sides.addPages pageElements
    
  rotateCubeBy: (times) ->
    unless times is Stage.NO_DISTANCE
      @_animator.rotateCube times
  

Stage.NO_DISTANCE          = 0
Stage.CSS_CLASS_HORIZONTAL = 'cubist-horizontal'
Stage.CSS_CLASS_VERTICAL   = 'cubist-vertical' 

module.exports = Stage

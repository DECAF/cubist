CubistOptions    = require '../config/CubistOptions'
Rotation         = require './Rotation'
Animator         = require './Animator'
Index            = require './Index'
Sides            = require './Sides'
cubeHtml         = require "../cube/html/cubeSides"
helper           = require '../util/helper'

$window = $ window

class Stage
  _stage                   : null
  _options                 : null
  _cubeEl                  : null
  _$rightFace              : null
  _$bottomFace             : null
  _$backFace               : null
  _animator                : null
  _index                   : null
  _stageWidth              : 0
  _stageHeight             : 0
  

  constructor : (@_stage, @_options) ->
    #isHorizontal
    helper.addClass @_stage, @_options.get(CubistOptions.CSS_CLASS_STAGE)

    @_cubeEl = document.createElement 'div'
    @_cubeEl.className = @_options.get(CubistOptions.CSS_CLASS_CUBE)
    @_cubeEl.innerHTML = cubeHtml
    @_$rightFace = $ @_cubeEl.querySelector('.cubist-face-right')
    @_$bottomFace = $ @_cubeEl.querySelector('.cubist-face-bottom')
    @_$backFace = $ @_cubeEl.querySelector('.cubist-face-back')
    @_stage.appendChild @_cubeEl

    @_animator = new Animator @_stage, @_cubeEl, @_options.get(CubistOptions.IS_ROTATED_VERTICALLY)
    @_index = new Index()
    @_bindEvents()
    @_draw()

  _bindEvents : ->
    $window.on "resize.cubist-#{helper.uid()}", =>
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
    depth = @_$rightFace.width() / 2
    @_animator.positionRear @_$backFace, depth
    @_animator.positionRight @_$rightFace, @_stageWidth - depth
    @_animator.positionBottom @_$bottomFace, @_stageHeight - depth

  getCubeEl : ->
    @_cubeEl

  getSideElements: ->
     
    
  addPages : (selector) ->
    pageElements = @_stage.querySelectorAll selector
    

    sides = new Sides @_cubeEl, @_options.get(CubistOptions.IS_ROTATED_VERTICALLY)
    sides.addPages pageElements
    
  rotateTo : (index) ->
    distance = @_index.getDistance index
    
    unless distance is Stage.NO_DISTANCE
      @_index.setIndex index
      console.log "rotating #{distance} times to index #{index}" 
      @_animator.rotateCube distance, -(@_stageHeight / 2) 
  

Stage.NO_DISTANCE          = 0
Stage.CSS_CLASS_HORIZONTAL = 'cubist-stage-horizontal'
Stage.CSS_CLASS_VERTICAL   = 'cubist-stage-vertical' 

module.exports = Stage

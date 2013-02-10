CubistOptions = require '../config/CubistOptions'
Rotation = require './Rotation'
Animator = require './Animator'
cubeHtml = require "../cube/html/cubeSides"
helper = require '../util/helper'
VendorTranslator = require '../util/VendorCssTranslator'
$window = $ window

class Stage
  _stage       : null
  _options     : null
  _cubeEl      : null
  _$rightFace  : null
  _$bottomFace : null
  _$backFace   : null
  _animator    : null
  _stageWidth  : 0
  _stageHeight : 0

  constructor : (@_stage, @_options) ->
    helper.addClass @_stage, @_options.get(CubistOptions.CSS_CLASS_STAGE)

    @_cubeEl = document.createElement 'div'
    @_cubeEl.className = @_options.get(CubistOptions.CSS_CLASS_CUBE)
    @_cubeEl.innerHTML = cubeHtml
    @_$rightFace = $ @_cubeEl.querySelector('.cubist-face-right')
    @_$bottomFace = $ @_cubeEl.querySelector('.cubist-face-bottom')
    @_$backFace = $ @_cubeEl.querySelector('.cubist-face-back')
    @_stage.appendChild @_cubeEl

    @_animator = new Animator @_cubeEl, @_options.get(CubistOptions.IS_ROTATED_VERTICALLY)


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
    @_setStagePerspective()

  _calculateSizes : ->
    @_stageWidth = @_stage.offsetWidth
    @_stageHeight = @_stage.offsetHeight

  _resizeFaces : ->
    depth = @_$rightFace.width() / 2
    @_animator.positionRear @_$backFace, depth
    @_animator.positionRight @_$rightFace, @_stageWidth - depth
    @_animator.positionBottom @_$bottomFace, @_stageHeight - depth

  _setStagePerspective : ->
    perspective = @_stageWidth * 60 / 100
    VendorTranslator.setStyle @_stage, 'perspective', perspective
  #if yes then "#{@_stageWidth * 60 / 100}px" else "0"

  getCubeEl : ->
    @_cubeEl

  getPages : (selector) ->
    @_stage.querySelectorAll selector

  rotateForward : ->
    rotate = @_rotation.getNextRotationFn()

  rotateBackward : ->
    rotate = @_rotation.getPrevRotationFn()


module.exports = Stage

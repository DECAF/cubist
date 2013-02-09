cubeHtml = require "../cube/html/cubeSides"
helper   = require '../util/helper'
$window  = $ window

class Stage
  _stage        : null
  _cubeEl       : null
  _$rightFace  : null
  _$bottomFace : null
  _stageWidth   : 0
  _stageHeight  : 0

  constructor : (@_stage, stageClass, cubeClass) ->
    helper.addClass @_stage, stageClass
    @_cubeEl = document.createElement 'div'
    @_cubeEl.className = cubeClass
    @_cubeEl.innerHTML = cubeHtml
    @_$rightFace = $ @_cubeEl.querySelector('.cubist-face-right')
    @_$bottomFace = $ @_cubeEl.querySelector('.cubist-face-bottom')
    @_stage.appendChild @_cubeEl

    @_bindEvents()
    @_draw()

  _bindEvents : ->
    $window.on "resize.cubist-#{helper.uid()}", =>
      @_onResize()

  _onResize : ->
    # rechts und unten berechnen
    @_draw()
    
  _draw: ->
    @_calculateSizes()
    @_resizeFaces()
    @_setStagePerspective()
    
  _calculateSizes : ->
    @_stageWidth = @_stage.offsetWidth
    @_stageHeight = @_stage.offsetHeight

  _resizeFaces : ->
    depth = @_$rightFace.width() / 2
    @_$rightFace.css
      transform: "rotateY(90deg) translateZ(#{@_stageWidth - depth}px)"
    @_$bottomFace.css
      transform: "rotateX(-90deg) translateZ(#{@_stageHeight - depth}px)"
  
  _setStagePerspective : ->
    perspective = if yes then "#{@_stageWidth * 60 / 100}px" else "0"
    @_stage.style.webkitPerspective = perspective 
    
    ###
      '-webkit-perspective' : perspective
      '-moz-perspective'    : perspective
      '-ms-perspective'     : perspective
      '-o-perspective'      : perspective
      'perspective'         : perspective
    ###  
  getCubeEl : ->
    @_cubeEl

  getPages : (selector) ->
    @_stage.querySelectorAll selector

  

module.exports = Stage

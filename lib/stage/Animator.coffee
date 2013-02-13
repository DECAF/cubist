Rotation         = require './Rotation'

class Animator
  _stage                   : null
  _$cube                   : null
  _isRotatedVertically     : null
  _rotation                : null
  onBeforeSideReveal       : null

  constructor : (@_stage, cubeEl, @_isRotatedVertically) ->
    @_$cube = $ cubeEl
    @_rotation = new Rotation @_isRotatedVertically

  resizeCube: (width, height) ->
    @_$cube.css
      transform : @_getRotationTransformation(@_rotation.getCurrentRotationFn(),@_getCubeZTranslate()) 
    
  rotateCube : (times) ->
    @_$cube.addClass(Animator.CSS_CLASS_TRANSITIONED).css
      transform  : @_getRotationTransformation(@_rotation.getRotationFn(times),@_getCubeZTranslate())

  _getCubeZTranslate : () ->
    depth = if @_isRotatedVertically then @_$cube.height() else @_$cube.width()
    -depth / 2

  _getRotationTransformation : (rotateFn, depth)->
    "translateZ(#{depth}px) #{rotateFn}"

Animator.ROTATE_EASING_START    = 'easeInQuad'
Animator.ROTATE_EASING_END      = 'easeOutQuad'
Animator.CSS_CLASS_TRANSITIONED = 'cubist-cube-transitioned'

module.exports = Animator
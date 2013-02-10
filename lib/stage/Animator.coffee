Rotation = require './Rotation'

class Animator
  @_$cube    : null
  @_rotation : null

  constructor : (cubeEl, isRotatedVertically) ->
    @_$cube = $ cubeEl
    @_rotation = new Rotation isRotatedVertically

  positionRear : ($el, depth)->
    $el.css
      transform : @_getRotationTransformation @_rotation.getRearFaceRotationFn(), depth

  positionRight : ($el, depth)->
    $el.css
      transform : @_getRotationTransformation @_rotation.getRightFaceRotationFn(), depth

  positionBottom : ($el, depth)->
    $el.css
      transform : @_getRotationTransformation @_rotation.getBottomFaceRotationFn(), depth

  rotateCube : (rotateFn) ->
    cubeHeight = @_$cube.height()
    transformIn = "translateZ(-#{cubeHeight / 2}px) #{rotateFn}"
    transformOut = "translateZ(-#{cubeHeight / 2}px) #{rotateFn}"
    @_$cube.transition({
                       transform : "translateZ(-#{cubeHeight / 2}px) rotateX(-#{90}deg)"
                       }, 500, 'linear', ->
                         $cube.transition({
                                          transform : "translateZ(0px) rotateX(#{degree}deg)"
                                          }, 500, 'easeOutSine')
                      )

  _getRotationTransformation : (rotateFn, depth)->
    "#{rotateFn} translateZ(#{depth}px)"

  transit : () ->

module.exports = Animator
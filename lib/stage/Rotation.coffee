helper = require '../util/helper'

class Rotation
  _isVertical       : null
  _selectedRotation : null
  _currentRotation  : 0


  constructor     : (@_isVertical) ->
    @_selectedRotation = if @_isVertical then Rotation.ROTATE_X else Rotation.ROTATE_Y

  getCurrentRotationFn: ->
    @_getTransformRotation @_selectedRotation, @_currentRotation    
    
  getRotationFn : (times) ->
    if helper.isNumber times
      @_currentRotation = times * Rotation.FULL_FLIP + @_currentRotation
      @getCurrentRotationFn()


  _getTransformRotation : (direction, degree)->
    direction.replace Rotation.ROTATE_FN_DEG_PLACEHOLDER, degree
    
Rotation.FULL_FLIP                 = -90
Rotation.ROTATE_FN_DEG_PLACEHOLDER = '{{DEG}}'
Rotation.ROTATE_X                  = "rotateX(#{Rotation.ROTATE_FN_DEG_PLACEHOLDER}deg)"
Rotation.ROTATE_Y                  = "rotateY(#{Rotation.ROTATE_FN_DEG_PLACEHOLDER}deg)"

module.exports = Rotation
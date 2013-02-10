class Rotation
  _isVertical       : null
  _selectedRotation : null
  _currentRotation  : 0


  constructor     : (@_isVertical) ->
    @_selectedRotation = if @_isVertical then Rotation.ROTATE_X else Rotation.ROTATE_Y

  getRearFaceRotationFn : ->
    @_getTransformRotation @_selectedRotation, Rotation.REAR
  
  getRightFaceRotationFn : ->
    @_getTransformRotation Rotation.ROTATE_Y , Rotation.RIGHT

  getBottomFaceRotationFn : ->
    @_getTransformRotation Rotation.ROTATE_X, Rotation.BOTTOM
      
  getNextRotationFn : ->
    @_currentRotation + Rotation.FULL_FLIP

  getPrevRotationFn : ->
    @_currentRotation - Rotation.FULL_FLIP

  _getTransformRotation : (direction, degree)->
    direction.replace Rotation.ROTATE_FN_DEG_PLACEHOLDER, degree
    
Rotation.HALF_FLIP                 = 90
Rotation.FULL_FLIP                 = 180
Rotation.RIGHT                     = 90
Rotation.BOTTOM                    = -90
Rotation.REAR                      = 180

Rotation.ROTATE_FN_DEG_PLACEHOLDER = '{{DEG}}'
Rotation.ROTATE_X                  = "rotateX(#{Rotation.ROTATE_FN_DEG_PLACEHOLDER}deg)"
Rotation.ROTATE_Y                  = "rotateY(#{Rotation.ROTATE_FN_DEG_PLACEHOLDER}deg)"

module.exports = Rotation
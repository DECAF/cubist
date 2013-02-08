class Cube
  @SIDING_CLASS_APPENDIX : '-siding'
  @FRONT                 : 'cube-front'
  @BACK                  : 'cube-back'

  _el     : null
  _faces  : null
  _cube   : null
  _siding : null

  constructor : (@_el, containerClass) ->
    @_faces = []
    @_cube = document.createElement 'div'
    @_siding = document.createElement 'div'

    @_cube.className = containerClass
    @_siding.className = containerClass + Cube.SIDING_CLASS_APPENDIX

    @_el.appendChild @_cube

  addFace : (face) ->
    @_faces.push face
    @_hideFace @getFaceCount() - 1

  _hideFace : (index) ->
    @_siding.appendChild @_faces[index]?.el

  #_showFace: () ->  

  show : (index) ->
    @_cube.appendChild(@_faces[index].el) unless @_faces[index] is undefined

  getFaceCount : ->
    @_faces.length

module.exports = Cube
  
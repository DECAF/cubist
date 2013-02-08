Cube = require './Cube'
Face = require './Face'

class CubeRenderer
  _root  : null
  _cube  : null

  constructor : (cubistRootEl)->
    @_root = cubistRootEl

  getCube : (selector, containerClass)->
    @_cube = new Cube(@_root, containerClass)
    
    
    @_addFacesToCube @_findFaces(selector)
    
    return @_cube
    
  _findFaces: (selector) ->
    @_root.querySelectorAll selector

  _addFacesToCube : (faceElements) ->
    @_cube.addFace(new Face(el)) for el in faceElements

module.exports = CubeRenderer
Cube = require './Cube'

CubeFactory =
  getCube: (el, options) ->
    cube = new Cube(el, options)
    
    return cube
    
module.exports = CubeFactory
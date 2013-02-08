class CubistException extends Error
  constructor: (@message) ->
    @name    = 'CubistException'
                  
    
module.exports = CubistException     
  
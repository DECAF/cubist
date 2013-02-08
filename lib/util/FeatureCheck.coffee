CubistException = require './CubistException'

tests =
  jquery  :
    message : "jquery is missing. \nPlease use cubist.all.js or include it in your HTML. Get it here http://jquery.com"
    test    : ->
      typeof window.jQuery is "function"
  transit :
    message : "jquery.transit is missing. \nPlease use cubist.all.js or include it in your HTML. Get it here http://ricostacruz.com/jquery.transit/"
    test    : ->
      typeof window.jQuery.fn.transition is "function"

module.exports =
  check : ->
    for own aTest of tests
      throw new CubistException(tests[aTest].message) unless tests[aTest].test()       
        
    
    
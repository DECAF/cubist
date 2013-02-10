VENDORS = ['webkit', 'Moz', 'ms', 'O']
VendorCssTranslator =
  setStyle : (el, feature, style) ->
    vendorFeature = feature.charAt(0).toUpperCase() + feature.slice(1)
    el.style[feature] = style
    for vendor in VENDORS 
      el.style[vendor + vendorFeature] = style

module.exports = VendorCssTranslator
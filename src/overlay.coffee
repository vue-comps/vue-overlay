# out: ../overlay.js
overlay = null
module.exports = (Vue) ->
  unless overlay?
    overlay = Vue.extend(require('./overlay-component'))
    overlay = new overlay()
  return overlay

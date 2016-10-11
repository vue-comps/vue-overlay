# out: ../overlay.js
overlay = null
creator = (Vue) ->
  unless overlay?
    overlay = Vue.extend(creator.obj)
    overlay = new overlay().$mount()
  return overlay
creator.obj = require('./overlay-component')

module.exports = creator

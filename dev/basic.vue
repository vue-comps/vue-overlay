<template lang="jade">
.container
  button(@click="openOverlay") Open Overlay
  button(@click.prevent="openSecondOverlay",v-if="firstOpened",:style="buttonStyle") Open another Overlay
  a(href="https://github.com/vue-comps/vue-overlay/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
module.exports =
  mixins:[
    require("vue-mixins/getVue")
  ]
  data: ->
    firstOpened: false
    buttonStyle:
      position:"relative"
      "z-index": 0
  methods:
    openOverlay: (cb) ->
      @buttonStyle["z-index"] = @overlay.open
        onBeforeOpen: =>
          @firstOpened = true
        onBeforeClose: =>
          @firstOpened = false
        onOpened: cb
    openSecondOverlay: (cb) ->
      @overlay.open opacity:0.6,onOpened:cb
  compiled: ->
    @overlay = require("../overlay.js")(@getVue())

</script>

<style lang="stylus">
.container > a
  position absolute
  left 250px
  top 40px
</style>

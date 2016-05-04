<template lang="jade">
.container
  button(@click="openOverlay") Open Overlay
  button(@click.prevent="openSecondOverlay",v-if="firstOpened",:style="buttonStyle") Open blue Overlay
  button(@click.prevent="closeFirstOverlay",v-if="firstOpened && secondOpened",:style="button2Style") Close bottom Overlay first
  br
  button(@click.prevent="openScrollOverlay") Overlay with allowScroll
  a(href="https://github.com/vue-comps/vue-overlay/blob/master/dev/basic.vue") source
div(style="margin:auto;text-align:center;height:2000px") something centered (shouldn't move)
</template>

<script lang="coffee">
module.exports =
  mixins:[
    require("vue-mixins/getVue")
  ]
  data: ->
    firstOpened: false
    secondOpened: false
    buttonStyle:
      position:"relative"
      zIndex: 0
    button2Style:
      position:"relative"
      zIndex: 0
  methods:
    openOverlay: (cb) ->
      @result = @overlay.open
        onBeforeOpen: =>
          @firstOpened = true
        onBeforeClose: =>
          @firstOpened = false
        onOpened: cb
      @buttonStyle.zIndex = @result.zIndex
    openSecondOverlay: (cb) ->
      result = @overlay.open
        opacity:0.6
        color: "blue"
        onBeforeOpen: =>
          @secondOpened = true
        onBeforeClose: =>
          @secondOpened = false
        onOpened:cb
      @button2Style.zIndex = result.zIndex
    openScrollOverlay: ->
      @overlay.open allowScroll:true
    closeFirstOverlay: ->
      @result.close()
  compiled: ->
    @overlay = require("../overlay.js")(@getVue())

</script>

<style lang="stylus">
.container > a
  position absolute
  left 250px
  top 40px
</style>

<template lang="pug">
.container
  button(@click="openOverlay") Open Overlay
  button(
    @click.prevent="openSecondOverlay",
    :style="buttonStyle",
    v-if="firstOpened"
    ) Open blue Overlay
  button(
    @click.prevent="closeFirstOverlay",
    :style="button2Style",
    v-if="bothOpened"
    ) Close bottom Overlay first
  br
  button(@click.prevent="openScrollOverlay") Overlay with allowScroll
  a(href="https://github.com/vue-comps/vue-overlay/blob/master/dev/basic.vue",style="margin: 20px") source
  div(style="margin:auto;text-align:center;height:2000px") something centered (shouldn't move on disapearing of the scrollbar)
</template>

<script lang="coffee">
module.exports =
  mixins:[
    require("vue-mixins/vue")
  ]
  computed:
    bothOpened: -> @firstOpened and @secondOpened
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
  mounted: ->
    @overlay = require("../overlay.js")(@Vue)

</script>

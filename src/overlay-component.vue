// out: ..
<template lang="jade">
div#overlay(
  v-bind:style="style"
  @click="dismiss | notPrevented | prevent"
  @keyup.esc="dismiss | notPrevented | prevent"
  )
</template>

<script lang="coffee">
module.exports =

  mixins:[
    require("vue-mixins/setCss")
  ]

  filters:
    notPrevented: require("vue-filters/notPrevented")
    prevent: require("vue-filters/prevent")

  data: ->
    stack: []
    style:
      opacity: 0
      "z-index": 995
      position: "fixed"
      top: "-10px"
      left: 0
      right: 0
      height: "120vh"
      "background-color": "black"
      "will-change": "opacity"
    fade: ({el,opacity,cb}) ->
      @style.opacity = opacity
      cb?()

  el: -> document.createElement "div"

  methods:

    dismiss: -> @close() if @stack[@stack.length-1].dismissable

    open: (options={}) ->
      if @stack.length == 0
        @$appendTo('body')
        @setCss(document.body,"overflow","hidden")
      options.opacity ?= 0.5
      options.dismissable ?= true
      @stack.push options
      options.onBeforeOpen?()
      @style["z-index"] += 5
      @fade el:@$el, opacity:options.opacity, cb:options.onOpened
      return @style["z-index"]+1

    close: ->
      options = @stack.pop()
      if options?
        if @stack.length == 0
          @setCss(document.body,"overflow")
          opacity = 0
        else
          opacity = @stack[@stack.length-1].opacity
        options.onBeforeClose?()
        @style["z-index"]-=5
        @fade el:@$el, opacity:opacity, cb: =>
          options.onClosed?()
          @$remove() if @stack.length == 0
</script>

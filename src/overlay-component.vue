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
  props:
    "fade":
      type: Function
      default: ({el,opacity,cb}) ->
        @style.opacity = opacity
        cb()
  filters:
    notPrevented: require("vue-filters/notPrevented")
    prevent: require("vue-filters/prevent")

  data: ->
    style:
      opacity: 0
      zIndex: 995
      position: "fixed"
      top: "-10px"
      left: 0
      right: 0
      height: "120vh"
      backgroundColor: "black"
      willChange: "opacity"


  el: -> document.createElement "div"

  compiled: ->
    @stack = []

  methods:

    dismiss: (e) -> @close() if @stack[@stack.length-1].dissmissible

    setScroll: (options) ->
      if options.allowScroll
        @setCss(document.body,"overflow")
      else
        @setCss(document.body,"overflow","hidden")

    open: (options={}) ->
      if @stack.length == 0
        @$appendTo('body')
      @setScroll(options)
      options.opacity ?= 0.5
      options.dissmissible ?= true
      @stack.push options
      options.onBeforeOpen?()
      @style.zIndex += 5
      options.zIndex = @style.zIndex
      @fade el:@$el, opacity:options.opacity, cb: -> options.onOpened?()
      return {zIndex: @style.zIndex+1, close: (callCbs=false) => @close(options,callCbs)}

    close: (options=@stack[@stack.length-1],callCbs=true) ->
      if options? and (index = @stack.indexOf(options)) >-1
        @stack.splice(index,1)
        if @stack.length == 0
          @setScroll(allowScroll:true)
          opacity = 0
          @style.zIndex = 995
        else
          lastItem = @stack[@stack.length-1]
          @setScroll(lastItem)
          opacity = lastItem.opacity
          @style.zIndex = lastItem.zIndex
        options.onBeforeClose?() if callCbs
        @fade el:@$el, opacity:opacity, cb: =>
          options.onClosed?() if callCbs
          @$remove() if @stack.length == 0
</script>

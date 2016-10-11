// out: ..
<template lang="pug">
div(
  style="opacity:0;position:fixed;top:-10px;left:0;right:0;height:120vh;willChange:opacity",
  :style="{zIndex:zIndex,backgroundColor:color}",
  @click="dismiss"
  )
</template>

<script lang="coffee">
module.exports =

  mixins:[
    require("vue-mixins/setCss")
    require("vue-mixins/onDocument")
    require("vue-mixins/getViewportSize")
  ]

  computed:
    zIndex: ->
      if @lastItem?
        return @lastItem.zIndex
      return 995
    color: ->
      if @lastItem? and @lastItem.color
        return @lastItem.color
      return "black"
    opacity: ->
      if @lastItem?
        return @lastItem.opacity if @lastItem.opacity?
        return 0.5
      return 0
    dismissable: ->
      if @lastItem? and @lastItem.dismissable?
        return @lastItem.dismissable
      return true
    lastItem: ->
      if @stack.length > 0
        li = @stack[@stack.length-1]
        @updateScroll(li)
        @updateKeyListener(true)
        return li
      @updateScroll()
      @updateKeyListener()
      return null

  data: ->
    stack: []

  methods:

    fade: ({el,opacity,cb}) ->
      @setCss(el,"opacity",opacity)
      cb()

    dismiss: (e) ->
      if e? and not e.defaultPrevented
        if @dismissable
          return null if e.type=="keyup" and e.which != 27
          @close()
          e.preventDefault()

    updateKeyListener: (set) ->
      if set and not @removeListener
        @removeListener = @onDocument "keyup", @dismiss unless @removeListener
      else
        @removeListener?()
        @removeListener = null


    updateScroll: (options) ->
      style = {o:null,m:null}
      if options and not options.allowScroll
        return null if @scrollDisabled
        style.o = "hidden"
        style.m = @getViewportSize().width - document.documentElement.clientWidth + "px"
        @scrollDisabled = true
      else
        @scrollDisabled = false
      @setCss(document.documentElement,"overflow",style.o)
      @setCss(document.documentElement,"margin-right",style.m)

    open: (options={}) ->
      document.body.appendChild(@$el) unless @lastItem?
      options.onBeforeOpen?()
      newZIndex = @zIndex + 5
      if not options.zIndex? or options.zIndex <= newZIndex
        options.zIndex = newZIndex
      @stack.push options
      @fade el:@$el, opacity:@opacity, cb: -> options.onOpened?()
      return {zIndex: @zIndex+1, close: (callCbs=true) => @close(options,callCbs)}

    close: (options=@lastItem,callCbs=true) ->
      if (index = @stack.indexOf(options)) >-1
        @stack.splice(index,1)
        options.onBeforeClose?() if callCbs
        @fade el:@$el, opacity:@opacity, cb: =>
          options.onClosed?() if callCbs
          document.body.removeChild(@$el) unless @lastItem?
</script>

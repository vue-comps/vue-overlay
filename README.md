# vue-overlay

> To mask out the background when a dialog / modal or similar is opened, a overlay is needed.

### [Demo](https://vue-comps.github.io/vue-overlay)

### Features
- singleton & z-index management to allow stacking
- background doesn't move when scroll gets disabled

### Used in
- [side-nav](https://vue-comps.github.io/vue-side-nav)
- [modal](https://vue-comps.github.io/vue-comps-modal)

# Install

```sh
npm install --save-dev vue-overlay
// vue@1.0
npm install --save-dev vue-overlay@1
```
or include `build/bundle.js`.

## Usage
```coffee
overlay = require("vue-overlay")(Vue)
# or, when using bundle.js
overlay = window.vueComps.overlay
```
For examples see [`dev/`](dev/).
If you need to reliable get the `Vue` instance, see [vue-mixins/vue](https://github.com/paulpflug/vue-mixins#vue)

{zIndex, close} = overlay.open(options)
---
  - `zIndex` - the z-index of the opened overlay - will be raised by 5 for each overlay
  - `close(callHooks=true)` - shortcut for `overlay.close(options,callHooks)` - options will be the same instance used for opening
  - `Options`

Name | type | default | description
---:| --- | ---| ---
opacity | Number | 0.5 | opacity of the overlay
dismissable | Boolean | true | is the overlay dismissable by click or ESC?
onBeforeOpen | Function | null | hook before open animation
onOpened | Function | null | hook after open animation
onBeforeClose | Function | null | hook before close animation
onClosed | Function | null | hook after close animation
allowScroll | Boolean | false | don't set `overflow:hidden` on body
color | String | "black" | background-color of the overlay
zIndex | Number | 1000 | minimum zIndex for the new overlay, cannot be lower than 1000

overlay.close(options=lastOverlay, callHooks=true)
---
- `options` the options object which was used to open a overlay
- `callHooks` set to `false` to suppress the calls of `onBeforeClose` and `onClosed` of that overlay


overlay.fade({el,opacity,cb})
---
overwrite to add a animation
- `el` the `div` element of the overlay
- `opacity` the target opacity of the opening/closing
- `cb` a function which must be called when finished

`vue-overlay` is a singleton, so a fade function provided like this, will be used globally.
Only do this once:
```js
Velocity = require("velocity-animate")
Overlay = require("vue-overlay")
Overlay.obj.methods.fade = function ({el,opacity,cb}) {
  Velocity(el, {opacity: opacity}, {
    duration: 300,
    queue: false,
    easing: 'easeOutQuad',
    complete: cb
  })
}
```

## Changelog
- 2.0.0  
now compatible with vue 2.0.0  

# Development
Clone repository
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.

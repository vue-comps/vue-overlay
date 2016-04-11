# vue-overlay

To mask out the background when a dialog / modal or similar is opened, a overlay is needed.

### [Demo](https://vue-comps.github.io/vue-overlay)

### Used in
- [side-nav](https://vue-comps.github.io/vue-side-nav)
- [modal](https://vue-comps.github.io/vue-comps-modal)
# Install

```sh
npm install --save-dev vue-overlay
```
or include `build/bundle.js`.

## Usage
```coffee
# overlay is a singleton and is designed
# to be used in different places simultaniously
overlay = require("vue-overlay")(Vue)
# or, when using bundle.js
overlay = window.vueComps.overlay

# returns the z-index of the overlay + 1 (starts with 1001)
# and a function to close this specific overlay
{zIndex,close} = overlay.open(options)
overlay.open() # z-index will raise by 5

# close hooks of the first options object will be called
# and z-index will be lowered by 5
overlay.close()
overlay.close() # overlay really closes

# To close a specific overlay you can use
overlay.close(options) # where options must be the same object which is used to open
# or use the result from open
{close} = overlay.open()
close()

# the overlay comes without animation, but you can easily set them up,
# for example with velocity.js:
Velocity = require("velocity-animate")
overlay.fade = ({el,opacity,cb}) ->
  Velocity el, {opacity: opacity},
    {
      duration: 300
      queue: false
      easing: 'easeOutQuad'
      complete: cb
    }
```

For examples see [`dev/`](dev/).
#### Options
| Name | type | default | description |
| ---:| --- | ---| --- |
| opacity | Number | 0.5 | opacity of the overlay |
| dissmissible | Boolean | true | is the overlay dissmissible by click or ESC? |
| onBeforeOpen | Function | null | hook before open animation |
| onOpened | Function | null | hook after open animation |
| onBeforeClose | Function | null | hook before close animation |
| onClosed | Function | null | hook after close animation |

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

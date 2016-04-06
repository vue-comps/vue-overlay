# vue-overlay

To mask out the background when a dialog / modal or similar is opened, a overlay is needed.

### [See it in action](https://vue-comps.github.io/vue-overlay)

# Install

```sh
npm install --save-dev vue-overlay
```
or include `build/bundle.js`

## Usage
```coffee
# overlay is a singleton and is designed
# to be used in different places simultaniously
overlay = require("vue-overlay")(Vue)
# or, when using bundle.js
overlay = window.vueComps.overlay

# returns the z-index of the overlay + 1 (starts with 1001)
zindex = overlay.open(options)
overlay.open() # z-index will raise by 5

# close hooks of the first options object will be called
# and z-index will be lowered by 5
overlay.close()
overlay.close() # overlay really closes

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
#### Options
| Name | type | default | description |
| ---:| --- | ---| --- |
| opacity | Number | 0.5 | opacity of the overlay |
| dismissable | Boolean | true | is the overlay dismissable by click or ESC? |
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
Browse to `http://localhost:8080/`

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.

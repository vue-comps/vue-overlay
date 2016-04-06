# vue-overlay

To mask out the background when a dialog / modal or similar is opened, a overlay is needed.

### [See it in action](https://vue-comps.github.io/vue-overlay)

Only for [**webpack**](https://webpack.github.io/) workflows.


# Install

```sh
npm install --save-dev vue-overlay
```

## Usage
```coffee
overlay = require("../overlay.js")(Vue) # overlay is a singleton

zindex = overlay.open(options) # returns the z-index of the overlay + 1
overlay.close()
```
#### Options
| Name | type | default | description |
| ---:| --- | ---| --- |
| opacity | Number | 0.5 | opacity of the overlay |
| dismissable | Boolean | true | Is the overlay dismissable by click or ESC? |
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

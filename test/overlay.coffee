env = null
describe "overlay", ->

  describe "basic env", ->

    before ->
      env = loadComp(require("../dev/basic.vue"))

    after ->
      unloadComp(env)

    it "should load and mount overlay", ->
      should.exist env.overlay
      should.exist env.overlay.$el

    it "should open first overlay", (done) ->
      env.openOverlay ->
        env.$nextTick ->
          env.firstOpened.should.be.true
          if window.getComputedStyle
            style = window.getComputedStyle(env.overlay.$el)
            style.getPropertyValue("opacity").should.equal '0.5'
            style.getPropertyValue("z-index").should.equal '1000'
          done()

    it "should open second overlay", (done) ->
      env.openSecondOverlay ->
        env.$nextTick ->
          if window.getComputedStyle
            style = window.getComputedStyle(env.overlay.$el)
            style.getPropertyValue("opacity").should.equal '0.6'
            style.getPropertyValue("z-index").should.equal '1005'
          env.overlay.close()
          env.overlay.close()
          done()

    it "should not close when not dismissable", (done) ->
      env.overlay.open(dismissable:false,onClosed:done)
      env.overlay.dismiss()
      env.overlay.stack.length.should.equal 1
      env.overlay.close()

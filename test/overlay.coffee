env = null
describe "overlay", ->

  describe "basic env", ->

    before ->
      env = loadComp(require("../dev/basic.vue"))

    after ->
      unloadComp(env)

    it "should load overlay", ->
      should.exist env.overlay
      env.overlay.$el.parentNode.nodeType.should.equal 11

    it "should open first overlay", (done) ->
      env.openOverlay()
      env.firstOpened.should.be.true
      env.overlay.style["z-index"].should.equal 1000
      done()

    it "should open second overlay", (done) ->
      env.openSecondOverlay()
      env.overlay.style["z-index"].should.equal 1005
      env.overlay.close()
      env.overlay.close()
      done()

    it "should not close when not dismissable", (done) ->
      env.overlay.open(dismissable:false)
      env.overlay.dismiss()
      env.overlay.stack.length.should.equal 1
      env.overlay.close()
      done()

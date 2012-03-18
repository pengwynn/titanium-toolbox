Spine ?= require('spine')

Spine.Model.Local =
  extended: ->
    @change @saveLocal
    @fetch @loadLocal

  saveLocal: ->
    result = JSON.stringify(@)
    Ti.App.Properties.setString @className, result

  loadLocal: ->
    result = Ti.App.Properties.getString @className
    @refresh(result or [])

module?.exports = Spine.Model.Local

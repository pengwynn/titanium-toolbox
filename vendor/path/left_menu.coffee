createLeftMenu = ->

  window = Ti.UI.createWindow
    left: 0
    width: 290
    zIndex: 1
    backgroundColor: 'red'

  label = Ti.UI.createLabel
    text: 'Left'
  window.add label

  window


module.exports = createLeftMenu

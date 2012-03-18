createLeftMenu = ->

  window = Ti.UI.createWindow
    right: 0
    width: 290
    zIndex: 1
    backgroundColor: 'blue'

  label = Ti.UI.createLabel
    right: 0
    text: 'Right'
    textAlign: 'right'
  window.add label

  window


module.exports = createLeftMenu

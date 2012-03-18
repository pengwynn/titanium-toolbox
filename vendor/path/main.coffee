createMainWindow = ->

  MENU_WIDTH = 290
  MOVEMENT_THRESHOLD = 30
  touchStartX = 0
  touchStarted = false
  isToggled = false

  window = Ti.UI.createWindow
    left: 0
    zIndex: 10

  # Animations
  animation_left = Ti.UI.createAnimation
    left: MENU_WIDTH
    duration: 500
    curve: Ti.UI.iOS.ANIMATION_CURVE_EASE_OUT

  animation_negative_left = Ti.UI.createAnimation
    left: -MENU_WIDTH
    duration: 500
    curve: Ti.UI.iOS.ANIMATION_CURVE_EASE_OUT

  animation_right = Ti.UI.createAnimation
    left: 0
    duration: 500
    curve: Ti.UI.iOS.ANIMATION_CURVE_EASE_OUT

  left_menu = require('ui/left_menu')()
  left_menu.open()

  right_menu = require('ui/right_menu')()
  right_menu.open()


  chart_window = require('ui/chart/window')()

  nav = Ti.UI.iPhone.createNavigationGroup
    window: chart_window
    left: 0
    width: Ti.Platform.displayCaps.platformWidth

  window.add nav

  # Methods
  wireUpChildWindowAnimationHooks = (child_window) ->

    child_window.addEventListener 'singletap', (e) ->
      window.animate animation_right

    child_window.addEventListener 'touchstart', (e) ->
      touchStartX = parseInt(e.x,10)

    child_window.addEventListener 'touchend', (e) ->
      if touchStarted
        touchStarted = false
        if window.left < 0
          if window.left <= -140
            window.animate animation_negative_left
            isToggled = true
          else
            window.animate animation_right
        else
          if window.left >= 140
            window.animate animation_left
            isToggled = true
          else
            window.animate animation_right
            isToggled = false

    child_window.addEventListener 'touchmove', (e) ->
      x = parseInt(e.globalPoint.x, 10)
      newLeft = x - touchStartX
      window.left = newLeft if touchStarted && (newLeft <= MENU_WIDTH && newLeft >= -MENU_WIDTH)
      touchStarted = newLeft > MOVEMENT_THRESHOLD || newLeft < -MOVEMENT_THRESHOLD
      if newLeft > MOVEMENT_THRESHOLD
        right_menu.hide()
        left_menu.show()
      if newLeft < -MOVEMENT_THRESHOLD
        left_menu.hide()
        right_menu.show()


  # Events


  wireUpChildWindowAnimationHooks chart_window

  window

module.exports = createMainWindow

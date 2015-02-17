navHeight = 49
statusBarHeight = 10
navFontSize = 24
contentPadding = 10
primaryColor = 'red'
primaryTextColor = 'white'

Template.main.styles
  'nav.height': navHeight
  'nav.fontSize': navFontSize
  'nav.textColor': primaryTextColor
  'nav.backgroundColor': primaryColor
  'nav.statusBar.height': statusBarHeight
  'content.top': navHeight
  'content.padding': contentPadding
  'content.textColor': 'black'
  'content.backgroundColor': 'white'
  'menu.width': 200
  'menu.backgroundColor': primaryColor
  'menu.textColor': primaryTextColor
  'menu.statusBar.height': statusBarHeight
  'menu.handle.height': navHeight
  'menu.handle.fontSize': navFontSize
  'menu.handle.padding': contentPadding

Template.main.events
  'nav.left': (e,t) -> console.log "left!"
  'nav.right': (e,t) -> console.log "right!"
  'menu.item': (elem) -> console.log "menu item", elem
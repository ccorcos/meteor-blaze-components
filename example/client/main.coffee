Template.main.styles
  'nav.height': 49
  'content.top': 49
  'nav.fontSize': 24
  'nav.textColor': 'white'
  'nav.backgroundColor': 'red'
  'nav.statusBar.height': 10
  'content.padding': 10
  'content.textColor': 'black'
  'content.backgroundColor': 'white'

Template.main.events
  'nav.left': (e,t) -> console.log "left!"
  'nav.right': (e,t) -> console.log "right!"
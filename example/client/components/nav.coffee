Template.nav.styles
  'nav.height': 49
  'nav.statusBar.height': 10
  'nav.fontSize': 24
  'nav.textColor': 'white'
  'nav.backgroundColor': 'red'
  'nav.padding': 10

Template.nav.css ->
  navCSS = css '.nav'
    .boxSizing        'border-box'
    .fp()
    .textOverflow     'ellipsis'
    .height         => @style('nav.height')
    .lineHeight     => @style('nav.height') - @style('nav.statusBar.height')
    .pt             => @style('nav.statusBar.height')
    .fontSize       => @style('nav.fontSize')
    .textAlign         'center'
    .color          => @style('nav.textColor')
    .bg             => @style('nav.backgroundColor')

  leftCSS = navCSS.child('.left')
    .position     'absolute'
    .top        => @style('nav.statusBar.height')
    .left(0)
    .height     => @style('nav.height') - @style('nav.statusBar.height')
    .pl         => @style('nav.padding')

  rightCSS = navCSS.child('.right')
    .position     'absolute'
    .top        => @style('nav.statusBar.height')
    .right(0)
    .height     => @style('nav.height') - @style('nav.statusBar.height')
    .pr         => @style('nav.padding')

  return [navCSS, rightCSS, leftCSS]

Template.nav.events
  'click .left':  (e,t) -> t.trigger('nav.left')
  'click .right': (e,t) -> t.trigger('nav.right')




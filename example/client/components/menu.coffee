Template.menu.styles
  'menu.width': 200
  'menu.nav.height': 49
  'menu.backgroundColor': 'blue'
  'menu.textColor': 'white'

Template.menu.css ->
  menuCSS = css('.menu')
    .userSelect  'none'
    .boxSizing   'border-box'
    .zIndex       1
    .position    'absolute'
    .top          0
    .bottom       0
    # .right        100, 'pc'
    .width     => @style('menu.width')
    .color     => @style('menu.textColor')
    .bg        => @style('menu.backgroundColor')
    .left         0
    .transform => 
      width = @style('menu.width')
      return "translateX(-#{width}px)"

  handleCSS = menuCSS.child('.handle')
    .position       'absolute'
    .top             0
    .left            100, 'pc'
    .height       => @style('menu.nav.height')
    .width        => @style('menu.nav.height')
    .lineHeight   => @style('menu.nav.height')
    .textAlign      'center'
    .color          'inherit'
    .bg             'inherit'

  itemCSS = menuCSS.child('.item')
    .width            100, 'pc'
    .textAlign       'center'
    .height        => @style('menu.nav.height')
    .lineHeight    => @style('menu.nav.height')
    .borderBottom  => 
      color = @style('menu.textColor')
      return "1px solid #{color}"

  return [menuCSS, handleCSS, itemCSS]
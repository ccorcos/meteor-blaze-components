Template.content.styles
  'content.textColor': 'black'
  'content.backgroundColor': 'white'
  'content.padding': 10
  'content.top': 0
  
Template.content.css ->
  css
    '.content':
      position:           'absolute'
      toppx:            => @style('content.top')
      bottom:              0
      left:                0
      right:               0
      color:            => @style('content.textColor')
      backgroundColor:  => @style('content.backgroundColor')
      paddingpx:        => @style('content.padding')


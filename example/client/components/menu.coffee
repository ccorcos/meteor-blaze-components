Template.menu.styles
  'menu.width': 200
  'menu.backgroundColor': 'blue'
  'menu.textColor': 'white'
  'menu.statusBar.height': 10
  'menu.handle.height': 49
  'menu.handle.fontSize': 24
  'menu.handle.padding': 10

Template.menu.css ->
  menuCSS = css('.menu')
    .userSelect  'none'
    .boxSizing   'border-box'
    .pt        => @style('menu.statusBar.height') 
    .zIndex       1
    .position    'absolute'
    .top          0
    .bottom       0
    .width     => @style('menu.width')
    .color     => @style('menu.textColor')
    .bg        => @style('menu.backgroundColor')
    .left         0
    .transform => 
      width = @style('menu.width')
      return "translateX(-#{width}px)"

  handleCSS = menuCSS.child('.handle')
    .boxSizing   'border-box'
    .position       'absolute'
    .top             0
    .left            100, 'pc'
    .height       => @style('menu.handle.height')
    .width        => @style('menu.handle.height')
    .lineHeight   => @style('menu.handle.height') - @style('menu.statusBar.height')
    .color          'inherit'
    .bg             'inherit'
    .pt          => @style('menu.statusBar.height') 
    .pl          => @style('menu.handle.padding')
    .fontSize    => @style('menu.handle.fontSize')


  itemCSS = menuCSS.child('.item')
    .width            100, 'pc'
    .textAlign       'center'
    .height        => @style('menu.handle.height') - @style('menu.statusBar.height')
    .lineHeight    => @style('menu.handle.height')
    .borderBottom  => 
      color = @style('menu.textColor')
      return "1px solid #{color}"

  return [menuCSS, handleCSS, itemCSS]

Template.menu.events
  'click .item': (e,t) -> t.trigger('menu.item', e.target)

strangle = (x, maxMin) ->
  x = Math.max(x, maxMin[0])
  x = Math.min(x , maxMin[1])
  return x

Template.menu.rendered = ->
  self = this

  menuWidth = @style('menu.width')

  # start stream of x position values
  toushStart = @eventStream("touchstart", ".handle")
    .map (e) -> e.originalEvent.touches[0].pageX
  mouseDown = @eventStream("mousedown", ".handle")
    .map (e) -> e.pageX
  startStream = Tracker.mergeStreams(toushStart, mouseDown)

  # cancel on a variety of annoying events
  touchEnd = self.eventStream("touchend", ".view", true)
  touchCancel = self.eventStream("touchcancel", ".view", true)
  touchLeave = self.eventStream("touchleave", ".view", true)
  mouseUp   = self.eventStream("mouseup", ".view", true)
  mouseOut  = self.eventStream("mouseout", ".view", true)
  mouseOffPage = mouseOut
    .filter (e) -> (e.relatedTarget or e.toElement) is undefined
  endStream = Tracker.mergeStreams(mouseUp, mouseOffPage, touchEnd, touchCancel, touchLeave)

  # create a move stream on demand returning the x position values
  mouseMove = self.eventStream("mousemove", ".view", true)
    .map (e) -> e.pageX
  touchMove = self.eventStream("touchmove", ".view", true)
    .map (e) -> e.originalEvent.touches[0].pageX
  moveStream = Tracker.mergeStreams(mouseMove, touchMove)

  # create an animation stream to block the start stream from interrupting an animation
  animatingStream = @stream(false)

  # get the jquery object we're going to drag
  # $menu = $(@find('.menu'))
  $menu = $('.view')

  startStream
    .unless(animatingStream)
    .map (x) ->

      initLeft = $menu.position().left
      offset = initLeft - x
      lastLeft = initLeft
      velocity = 0

      # toggle menu position
      toggle = ->
        if lastLeft > menuWidth/2
          # close it
          $menu.velocity({translateX: [0, menuWidth], translateZ: [0, 0]}, {duration: 400, easing: 'ease-in-out', complete: -> animatingStream.set(false)})
        else
          # open it
          $menu.velocity({translateX: [menuWidth, 0], translateZ: [0, 0]}, {duration: 400, easing: 'ease-in-out', complete: -> animatingStream.set(false)})

      # resolve menu position
      resolve = ->
        animatingStream.set(true)
        # wait for animation to finish
        if initLeft is lastLeft and velocity is 0
          toggle()
          return

        momentum = velocity*3
        if lastLeft + momentum > menuWidth/2
          momentum = Math.abs(momentum)
          duration = Math.min((menuWidth-lastLeft)/momentum*100, 400)
          $menu.velocity({translateX: menuWidth, translateZ: 0}, {duration: duration, easing: 'ease-out', complete: -> animatingStream.set(false)})
        else
          momentum = Math.abs(momentum)
          duration = Math.min(lastLeft/momentum*100, 400)
          $menu.velocity({translateX: 0, translateZ: 0}, {duration: duration, easing: 'ease-out', complete: -> animatingStream.set(false)})
      
      moveStream
        .takeUntil(endStream, resolve)
        .forEach (x) ->
          # wait for animation to finish
          left = strangle(x + offset, [0, menuWidth])
          velocity = left - lastLeft
          lastLeft = left
          $menu.velocity({translateX: left, translateZ: 0}, {duration: 0})



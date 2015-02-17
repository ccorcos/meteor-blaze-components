# Blaze Components

This package expores a way of making components with blaze. Its highly a work in progress.

## Getting Started

Clone this package into your `packages/` directory of your meteor project and then run `meteor add ccorcos:blaze-components`. If you want to run the demo, then you can symlink the package with `ln -s /path/to/ccorcos:blaze-components /path/to/ccorcos:blaze-components/example/packages`.

### Styling

First, this package depends on [`ccorcos:reactive-css`](https://github.com/ccorcos/meteor-reactive-css) and exposes a `Template.myTemplate.css` function for defining css rules. This function takes in a function that returns an array or css objects so the template can create css rules onCreated and stop the autoruns onDestroyed.

This package also exposes a `Template.myTemplate.styles` function for parameterizing your components. These styles can be overridden by parent templates. To get the proper style, use the `Template.instance.style` function. This function is reactive as well. 

Here is an example of a simple "content" block helper component.

```html
<template name="content">
  <div class="content">
    {{> UI.contentBlock}}
  </div>
</template>
```

```coffee
Template.content.styles
  'content.textColor':       'black'
  'content.backgroundColor': 'white'
  'content.padding':          10
  'content.top':              0
  
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
```

Maybe you have a navbar that you want to sit on top of the content block.

```html
<template name="main">
  {{>nav}}
  {{#content}}
    ...
  {{/content}}
</template>
```

In this case, can override the `'content.top'` style in the main template.

```coffee
Template.main.styles
  'nav.height': 49
  'content.top': 49
```

### Events

Another feature of this package is triggering events in parent templates. `Template.instance.trigger(name, args...)` will search all of the eventMaps of its parent templates and trigger any event of a certain name with whatever arguments supplied. For example, you can trigger navbar buttons in the main template like this:

```coffee
Template.nav.events
  'click .left':  (e,t) -> t.trigger('nav.left')
  'click .right': (e,t) -> t.trigger('nav.right')

Template.main.events
  'nav.left': (e,t)  -> console.log "left!"
  'nav.right': (e,t) -> console.log "right!"
```

## To Do / Quirks
- is it possible to use inline styles?

    Right now, the styles aren't strictly scoped to the template. This could be accomplished with inline styles. This would be doable if we could use Template.find, but we can't in Template.created and it wouldn't make much sense to do it in Template.rendered.

- what if we want to pass events to children to siblings?

    I could imagine this would be quite useful in certain places. For example, tapping the content view should close the menu. Opening the menu should disable the content and perhaps add an overlay. It would be convenient if these two components could respond to each other and manages their concerns separately.

- it would be great if components could have multiple UI blocks for creating layouts.

    What if a component has multiple subcomponents? For example, a header-content-footer view would make a lot of sense to be self-contained. Right now we have to create 3 different views and coordinate their styles through their parant template. I'm not sure this makes a lot of sense for more complicated layouts and components.

- is there some way to stop all autoruns from the ReactiveDict when the template id destroyed?

    I'm just not sure if ReactiveDicts need cleanup. Right now they are not.
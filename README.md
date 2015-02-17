Template.nav.css, pass a function or an object and autostop the autoruns
Template.nav.styles to set default styles but they can be overridden by parent templates











The goal of this project is to start building UI components based on protocols, inspired by Objective-C protocols. This will allow us to build more complicated nested UI components that speak to each other. For example:



Template.login
  view
    nav
    content
      form
        username
        password
        submit

# To Do

- template level inline CSS
- make the nav a block helper that has a nav wrapper. the content is the inside of it. this way we dont have to design this app such that two sibling templates have to know of each other's existence.
- better way for template styling
- better way for triggering parent events
- forms as blaze components!
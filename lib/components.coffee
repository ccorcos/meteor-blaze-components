Blaze.TemplateInstance.prototype.getParentNamed = (name) ->
  template = this
  while template
    if name is template.view.name.split('.').splice(1).join('.')
      return template

    view = template.view.originalParentView or template.view.parentView
    
    while view and (not view.template or view.name is '(contentBlock)')
      view = view.originalParentView or view.parentView

    template = view.templateInstance?()

  return template

triggerEventHelper = (name, template, event) ->
  while template
    if template.view.template.__eventMaps
      for eventMap in template.view.template.__eventMaps
        if eventMap[name]
          eventMap[name].apply(template.view, [event, template])

    view = template.view.originalParentView or template.view.parentView
    
    while view and (not view.template or view.name is '(contentBlock)')
      view = view.originalParentView or view.parentView

    template = view.templateInstance?()

Blaze.TemplateInstance.prototype.trigger = (name, args...) -> triggerEventHelper(name, this, args)

# Lets avoid globals for now.
# @trigger = (name) -> (e,t) -> triggerEventHelper(name, t, e)

Template.prototype.css = (value) ->
  if _.isFunction(value)
    @makeCSS = value
  else
    console.log "WARNING: Unknown input to Template.prototype.css"

Template.prototype.styles = (obj) ->
  if _.isObject(obj)
    @defaultStyles = obj
  else
    console.log "WARNING: Template.prototype.styles accepts a shallow object."


Template.onCreated ->
  if @view.template.defaultStyles
    @styles = new ReactiveDict()
    for k,v of @view.template.defaultStyles
      @styles.setDefault(k,v)

  @view.template.cssArray = []
  @view.template.cssArray = @view.template.makeCSS?.apply(this)

Template.onDestroyed ->
  for item in @view.template.cssArray
    item.stop()


Blaze.TemplateInstance.prototype.style = (name) ->
  s = @styles
  template = this
  
  Tracker.nonreactive ->
    if template.styles?.get?(name) is undefined
      console.log "WARNING: Must define default styles, " + template.view.name + " "+ name


  Tracker.nonreactive ->
    while template
      if template.styles and template.styles.get(name)
        s = do (template) -> template.styles


      view = template.view.originalParentView or template.view.parentView
      
      while view and (not view.template or view.name is '(contentBlock)')
        view = view.originalParentView or view.parentView

      template = view.templateInstance?()

  return s?.get(name)
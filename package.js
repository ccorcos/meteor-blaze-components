Package.describe({
  name: 'ccorcos:blaze-components',
  summary: 'A Meteor package for creating Blaze components.',
  version: '0.0.1',
  git: 'https://github.com/ccorcos/meteor-blaze-components'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1');

  api.use([
    'coffeescript',
    'templating',
    'aldeed:template-extension@3.4.1',
    'ccorcos:reactive-css@1.0.5'
  ], 'client');

  api.addFiles([
    'lib/components.coffee',
  ], 'client');
});
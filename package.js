Package.describe({
  name: 'ccorcos:blaze-components',
  // summary: 'Page transitions integrated with Iron Router.',
  version: '0.0.1',
  // git: 'https://github.com/ccorcos/meteor-transitioner'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1');

  api.use([
    'coffeescript',
    'templating',
    'aldeed:template-extension',
    'ccorcos:reactive-css'
  ], 'client');

  api.addFiles([
    'lib/components.coffee',
  ], 'client');
});
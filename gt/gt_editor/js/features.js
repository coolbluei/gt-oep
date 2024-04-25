(function ($, Drupal) {
  Drupal.behaviors.features = {
    attach: function (context, settings) {
      $('.page-node-type-feature .field--name-field-padding select').each(function(i, self) {
        if ($(self).nextAll('div.padding-hint-container').first().length == 0) {
          switch($(self).val()) {
            case 'padding-default':
              $(self).after('<div class="padding-hint-container"><img class="padding-hint" src="/' + settings.editor_path + '/images/padding-default-icon.svg" /></div>');
              break;
            case 'padding-vertical':
              $(self).after('<div class="padding-hint-container"><img class="padding-hint" src="/' + settings.editor_path + '/images/padding-vertical-icon.svg" /></div>');
              break;
            case 'padding-horizontal':
              $(self).after('<div class="padding-hint-container"><img class="padding-hint" src="/' + settings.editor_path + '/images/padding-horizontal-icon.svg" /></div>');
              break;
            case 'padding-both':
              $(self).after('<div class="padding-hint-container"><img class="padding-hint" src="/' + settings.editor_path + '/images/padding-vertical-horizontal-icon.svg" /></div>');
              break;
            default:
              $(self).after('<div class="padding-hint-container"><span class="padding-hint"></span></div>');
          }
        }
      });

      $('.page-node-type-feature .field--name-field-padding select').change(function(self) {
        switch($(self.target).val()) {
          case 'padding-default':
            $(self.target).next('.padding-hint-container').children('.padding-hint').replaceWith('<img class="padding-hint" src="/' + settings.editor_path + '/images/padding-default-icon.svg" />');
            break;
          case 'padding-vertical':
            $(self.target).next('.padding-hint-container').children('.padding-hint').replaceWith('<img class="padding-hint" src="/' + settings.editor_path + '/images/padding-vertical-icon.svg" />');
            break;
          case 'padding-horizontal':
            $(self.target).next('.padding-hint-container').children('.padding-hint').replaceWith('<img class="padding-hint" src="/' + settings.editor_path + '/images/padding-horizontal-icon.svg" />');
            break;
          case 'padding-both':
            $(self.target).next('.padding-hint-container').children('.padding-hint').replaceWith('<img class="padding-hint" src="/' + settings.editor_path + '/images/padding-vertical-horizontal-icon.svg" />');
            break;
          default:
            $(self.target).next('.padding-hint-container').children('.padding-hint').replaceWith('<span class="padding-hint"></span>');
        }
      });
    }
  }
})(jQuery, Drupal);

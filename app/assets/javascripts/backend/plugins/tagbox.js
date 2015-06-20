(function($) {
  $.fn.udongo_tagbox = function(options) {
    var settings = $.extend({
      items: 'items-path',
      limit: null,
      minLength: 2,
      on_add: function(tag, input) {},
      on_remove: function(tag, input) {},
    }, options);

    return this.each(function() {
      var input = $(this);

      if(typeof settings.items == 'string'){
        $.ajax({
          type: 'GET',
          url: input.data(settings.items)
        }).done(function(data){
          settings.items = data;
          return tagit(input, settings.items);
        });
      } else {
        return tagit(input, settings.items);
      };

      function tagit(input, items) {
        input.tagit({
          autocomplete: {
            minLength: settings.minLength,
            source: function(request, response) {
              response($.ui.autocomplete.filter(settings.items, request.term));
            },
          },
          allowSpaces: true,
          caseSensitive: false,
          removeConfirmation: true,
          tagLimit: settings.limit,
          beforeTagAdded: function(event, ui) {
            if($.isFunction(settings.on_add)){
              settings.on_add.call(this, ui.tag.find('.tagit-label').text(), input);
            }
          },
          afterTagRemoved: function(event, ui) {
            if($.isFunction(settings.on_remove)){
              settings.on_remove.call(this, ui.tag.find('.tagit-label').text(), input);
            }
          }
        });
      };
    });
  };
}(jQuery));

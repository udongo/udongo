(function($){
  $.fn.udongo_autocomplete = function(options) {
    var original_input = this;
    var settings = $.extend({
      minLength: 2,
      on_add: function(item) { return true; },
      on_remove: function(item) { return true; },
    }, options);

    add_li_to_ul = function(li) {
      if(last_item().length) {
        last_item().after(li);
      } else {
        ul().find('li.tagit-new').before(li);
      }

      li.find('.tagit-close').on('click', function(e){ remove_li(li) });
    };

    bootstrap = function(input, callback) {
      $.ajax({
        type: 'GET',
        url: input.data('path')
      }).done(function(data){
        generate_ul(input, data);
        generate_lis_from_value(data);
        callback(ul_input(), data);
      });
    };

    generate_li = function(ui) {
      classes = '{0} choice tagit-choice ui-widget-content ui-state-default ui-corner-all tagit-choice-editable';
      classes = classes.format(li_class(ui).substr(1));

      var data = '';
      for(var prop in ui.item) {
        data += ' data-{0}="{1}"'.format(prop, ui.item[prop]);
      }

      var item = $('<li class="{0}" {1} />'.format(classes, data));
      item.append($('<span class="tagit-label">{0}</span>'.format(ui.item.label)));
      item.append($('<a class="tagit-close"><span class="text-icon">×</span></a>'));
      return item;
    };

    generate_lis_from_value = function(data) {
      var value = original_input.val();
      var values = value.split(',');

      if(value !== '') {
        for(i = 0; i != values.length; i++) {
          o = data.filter(function(o){
            return o.value == values[i];
          });

          var item = generate_li({ item: o[0] });
          add_li_to_ul(item);
        }
      }
    };

    generate_ul = function(input, data) {
      var list = $('<ul class="autocomplete tagit ui-widget ui-widget-content ui-corner-all"/>');
      var data = original_input.data();

      for(var prop in data) {
        list.data(prop, data[prop]);
      }

      var new_input = $('<li class="tagit-new" />').append(
        $('<input type="text" class="ui-widget-content ui-autocomplete-input" autocomplete="off">')
      );
      new_input.find('input').on('keydown', function(e){
        if(e.keyCode == 8 && $(this).val() == '' && ul().find('li.choice').length > 0) {
          remove_li(last_item());
        }
      });

      list.append(new_input);
      input.after(list);
      input.addClass('hidden');

      return list;
    };

    last_item = function() {
      return ul().find('li.choice:last');
    };

    li_class = function(ui) {
      return '.item-{0}'.format(ui.item.value);
    };

    remove_li = function(item) {
      if($.isFunction(settings.on_remove) && settings.on_remove.call(this, item)) {
        item.remove();
      }
    };

    select = function(e, ui) {
      var input = $(this);
      var new_li = generate_li(ui);
      new_li.addClass('hidden');

      // blocks any new choices after reaching the limit
      if(ul().data('limit') !== 0 && ul().find('li.choice').length >= ul().data('limit')) {
        input.val('');
        return false;
      }

      add_li_to_ul(new_li);

      if($.isFunction(settings.on_add) && settings.on_add.call(this, new_li)) {
        new_li.removeClass('hidden');
        input.val('');
        return false;
      } else {
        // by returning true, we ensure the jQueryUI default select gets executed.
        return true;
      }
    };

    ul = function() {
      return $('ul.autocomplete');
    };

    ul_input = function() {
      return ul().find('input');
    };

    return original_input.each(function(){
      bootstrap($(this), function(input, data){
        input.autocomplete({
          minLength: settings.minLength,
          select: select,
          source: function(request, response) {
            response($.ui.autocomplete.filter(data, request.term));
          },
          // prevent value inserted on focus
          focus: function() {
            return false;
          }
        });
      });
    });
  };
}(jQuery));

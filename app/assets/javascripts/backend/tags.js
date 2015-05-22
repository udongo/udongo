var tags = {
  init: function() {
    $('input[data-tagbox]').udongo_tagbox({
      on_add: tags.add,
      on_remove: tags.remove
    });
  },

  add: function(tag, input) {
    tags.call('POST', tag, input);
  },

  remove: function(tag, input) {
    tags.call('DELETE', tag, input);
  },

  call: function(type, tag, input) {
    if(typeof type == 'undefined') return;

    $.ajax({
      url: input.data('base-path'),
      data: {
        locale: input.data('locale'),
        taggable_type: input.data('type'),
        taggable_id: input.data('id'),
        tag: tag
      },
      type: type
    });
  }
}

$(function(){ tags.init(); });

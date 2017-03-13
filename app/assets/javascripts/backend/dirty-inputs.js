var dirty_inputs = dirty_inputs || {
  init: function() {
    $('[data-dirty]').parents('form').find(':input').on('change, keydown', this.input_change_listener);
  },

  input_change_listener: function(e) {
    $(this).data('dirty', true);

    $('a').each(dirty_inputs.iterate_anchors_and_bind_click_warning);
  },

  anchor_click_warning_listener: function(e) {
    // FIXME: I'm not sure what the approach is to have a default label.
    // I'm sort of opposed to .js.erb files, but this might be the only way.
    if(!window.confirm('Je gaat de pagina verlaten en het formulier is nog niet bewaard.\nWil je doorgaan?')) {
      e.stopPropagation();
      e.preventDefault();
    }
  },

  iterate_anchors_and_bind_click_warning: function(){
    var anchor = $(this);
    var events = $._data(anchor[0], 'events');

    if(typeof events == 'undefined') {
      anchor.on('click', dirty_inputs.anchor_click_warning_listener);
    }
  }
};

$(function(){ dirty_inputs.init(); });

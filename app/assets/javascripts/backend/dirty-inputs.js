var dirty_inputs = dirty_inputs || {
  message: null,
  init: function() {
    $('[data-dirty]').parents('form').find(':input').on('change, keydown', this.input_change_listener);
  },

  input_change_listener: function(e) {
    // I have to set the message this way, because the trigger for the click
    // warning probably won't have the context of the form that this method has.
    var input = $(this);
    dirty_inputs.message = input.parents('form').find('[data-dirty]').text();
    input.data('dirty', true);
    $('a').each(dirty_inputs.iterate_anchors_and_bind_click_warning);
  },

  anchor_click_warning_listener: function(e) {
    if(!window.confirm(dirty_inputs.message)) {
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

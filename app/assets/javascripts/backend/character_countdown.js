if(typeof backend == 'undefined') var backend = {};

backend.character_countdown = {
  init: function() {
    $('[data-char-limit]').each(function(){
      var input = $(this);
      input.on('keyup', backend.character_countdown.keyup_listener);
      backend.character_countdown.prepare_input(input);
    });
  },

  append_container: function(input, remaining) {
    var container = input.parent().find('.char-limit-container');
    var label = backend.character_countdown.label(remaining);

    if(container.length === 0) {
      container = backend.character_countdown.new_container(label);
      input.after(container);
    } else {
      container.html(label);
    }

    backend.character_countdown.color_label(container, input.data('char-limit'), remaining);
  },

  color_label: function(container, limit, remaining) {
    if(remaining > limit * 0.1 && remaining <= limit * 0.25) container.css('color', '#ffc107');
    else if(remaining <= limit * 0.1) container.css('color', '#dc3545');
    else container.css('color', 'inherit');
  },

  keyup_listener: function(e) {
    e.preventDefault();
    backend.character_countdown.prepare_input($(this));
  },

  label: function(remaining) {
    if(typeof character_countdown_label == 'undefined') return remaining;
    return character_countdown_label.replace('%count%', remaining);
  },

  new_container: function(text){
    return $('<small class="char-limit-container form-text">'+ text +'</small>');
  },

  prepare_input: function(input) {
    var limit = input.data('char-limit');

    // A regular regex notation with /^$/ can't work. We need string
    // interpolation and a RegExp class instance to interpret the lookup string.
    var lookup = '.{'+ limit +'}(.*)';
    var extra = input.val().match(new RegExp(lookup), 'gi');

    var remaining = limit - input.val().length;
    backend.character_countdown.append_container(input, remaining);
  }
};

$(function(){ backend.character_countdown.init(); });

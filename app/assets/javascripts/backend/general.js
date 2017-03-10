var general = general || {
  init: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
    $('input, select').change(this.input_change_listener);
  },

  input_change_listener: function(e) {
    $(this).data('dirty', true);
  }
};

$(function(){ general.init(); });

var forms = forms || {
  bind_events: function() {
    this.hide_button_radio_targets();
    this.give_focus_to_first_visible_input();
    $('.button_radios label').on('click', this.button_radio_label_click_listener)
  },

  button_radio_label_click_listener: function(e) {
    var label = $(this);
    var target = $(label.data('target'));
    forms.hide_button_radio_targets();
    target.show();
  },

  hide_button_radio_targets: function() {
    $('.button_radios label').each(function(){
      var label = $(this);
      var target = $(label.data('target'));
      // TODO: hide all except the active one
      target.hide();
    });
  },

  give_focus_to_first_visible_input: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
  }
};

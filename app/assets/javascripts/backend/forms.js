var forms = forms || {
  bind_events: function() {
    this.give_focus_to_first_visible_input();
    this.button_radios.bind_events();
  },

  give_focus_to_first_visible_input: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
  }
};

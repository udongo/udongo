var forms = forms || {
  bind_events: function() {
    this.give_focus_to_first_visible_input();
    this.hide_button_radio_targets();
    $('.button_radios label').on('click', this.button_radio_label_click_listener)
  },

  button_radio_label_click_listener: function(e) {
    var label = $(this);
    var target = $(label.data('target'));

    forms.hide_button_radio_targets();
    target.show();
    setTimeout(function(){
      target.find('input').focus();
    }, 50);
  },

  hide_button_radio_targets: function() {
    $('.button_radios label').each(function(){
      var label = $(this);
      var target = $(label.data('target'));
      setTimeout(function(){
        if(!label.hasClass('active')) target.hide();
      }, 50);
    });
  },

  give_focus_to_first_visible_input: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
  }
};

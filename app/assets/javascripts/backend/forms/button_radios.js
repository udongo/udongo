var forms = forms || {};
forms.button_radios = forms.button_radios || {
  bind_events: function() {
    $('.button_radios label')
      .on('click', this.label_click_listener)
      .each(this.label_iterator);
  },

  data_target_for_label: function(label) {
    return $('[data-br="'+ label.data('target') +'"]');
  },

  hide_content: function() {
    $('.button_radios label').each(function(){
      forms.button_radios
        .data_target_for_label($(this))
        .hide();
    });
  },

  label_click_listener: function(e) {
    var target = forms.button_radios.data_target_for_label($(this));
    forms.button_radios.hide_content(); // Hide all content first...
    forms.button_radios.show_content(target); // ... before showing the active one.
  },

  // This determines if content for a given radio button may be visible.
  label_iterator: function() {
    var label = $(this);
    var target = forms.button_radios.data_target_for_label(label);
    if(label.hasClass('active')) forms.button_radios.show_content(target);
  },

  show_content: function(target) {
    target.show();
    setTimeout(function(){
      target.find('input').focus();
    }, 50);
  }
};

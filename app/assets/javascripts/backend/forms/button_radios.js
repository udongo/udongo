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

  label_click_listener: function(e) {
    var target = forms.button_radios.data_target_for_label($(this));

    forms.button_radios.hide_content();
    target.show();
    setTimeout(function(){
      target.find('input').focus();
    }, 50);
  },

  hide_content: function() {
    $('.button_radios label').each(function(){
      var label = $(this);
      var target = forms.button_radios.data_target_for_label(label);

      setTimeout(function(){
        if(!label.hasClass('active')) target.hide();
      }, 50);
    });
  },

  label_iterator: function() {
    var label = $(this);
    var target = forms.button_radios.data_target_for_label(label);
    if(label.hasClass('active')) target.show();
    label.on('click', forms.button_radios.label_click_listener);
  }

};

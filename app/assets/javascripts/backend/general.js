var general = general || {
  init: function() {
    $('[data-toggle="tooltip"]').tooltip();
    $('[href="#lity-close"]').on('click', this.lity_close_click_listener);
    if(typeof forms != 'undefined') forms.bind_events();
  },

  lity_close_click_listener: function(e) {
    e.preventDefault();
    $(parent.window.document).find('[data-lity-close=""]').trigger('click');
  }
};

$(function(){ general.init(); });

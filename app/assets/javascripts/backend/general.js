var general = general || {
  init: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
    $('[data-toggle="tooltip"]').tooltip();
    $('[href="#lity-close"]').on('click', this.lity_close_click_listener);
  },

  lity_close_click_listener: function(e) {
    e.preventDefault();
    $(parent.window.document).find('[data-lity-close=""]').trigger('click');
  }
};

$(function(){ general.init(); });

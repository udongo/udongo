var general = general || {
  init: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
    $('[data-toggle="tooltip"]').tooltip();
    $('[href="#lity-close"]').on('click', this.lity_close_click_listener);
    $('.form_toggle label').on('click', this.form_toggle_click_listener);
  },

  // TODO: See if this can be made generic
  form_toggle_click_listener: function(e) {
    var form = $(this).parents('form');
    var input = $(this).find('input');
    $('[data-button-radio-toggle]').addClass('d-none');
    $('.form_'+ input.val()).removeClass('d-none');
  },

  lity_close_click_listener: function(e) {
    e.preventDefault();
    $(parent.window.document).find('[data-lity-close=""]').trigger('click');
  }
};

$(function(){ general.init(); });

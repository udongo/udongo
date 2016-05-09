var general = general || {
  init: function() {
    $('form input:visible:not(.no-focus):first').focus();
    this.load_datepickers();
  },

  datepicker_icon_click_listener: function(e) {
    e.preventDefault();
    $(this).parents('.date_picker').find('input').trigger('focus');
  },

  load_datepickers: function() {
    var inputs = $('.date_picker input');
    if(typeof inputs.datepicker === 'function') {
      inputs.datepicker();
      $('.date_picker .input-group-addon').on('click', this.datepicker_icon_click_listener);
    }
  }
};

$(function(){ general.init(); });

var general = general || {
  init: function() {
    $('form input:visible:not(.no-focus):first').focus();
    $('.date_picker input').datepicker();
    $('.date_picker .input-group-addon').on('click', this.datepicker_icon_click_listener);
  },

  datepicker_icon_click_listener: function(e) {
    e.preventDefault();
    $(this).parents('.date_picker').find('input').trigger('focus');
  },
};

$(function(){ general.init(); });

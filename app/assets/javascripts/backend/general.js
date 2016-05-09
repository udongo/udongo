var general = general || {
  init: function() {
    $('form input:visible:not(.no-focus):first').focus();
    $('.datepicker input').datepicker();
    $('.datepicker .input-group-addon').on('click', this.datepicker_icon_click_listener);
  },

  datepicker_icon_click_listener: function(e) {
    e.preventDefault();
    $(this).parents('.datepicker').find('input').trigger('focus');
  },
};

$(function(){ general.init(); });

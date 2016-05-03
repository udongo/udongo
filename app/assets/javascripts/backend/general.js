var general = general || {
  init: function() {
    $('form input:visible:not(.no-focus):first').focus();
    $('.date_picker input').datepicker();
  }
};

$(function(){ general.init(); });

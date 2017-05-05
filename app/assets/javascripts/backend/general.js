var general = general || {
  init: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
    $('[data-toggle="tooltip"]').tooltip();
  }
};

$(function(){ general.init(); });

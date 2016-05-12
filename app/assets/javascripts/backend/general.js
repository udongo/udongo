var general = {
  init: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
  }
};

$(function(){ general.init(); });

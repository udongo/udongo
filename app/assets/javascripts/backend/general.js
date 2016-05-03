var general = general || {
  init: function() {
    $('form input:visible:not(.no-focus):first').focus();
  }
};

$(function(){ general.init(); });

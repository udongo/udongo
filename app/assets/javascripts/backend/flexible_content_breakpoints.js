var flexible_content_breakpoints = flexible_content_breakpoints || {
    init: function() {
      $('a[data-show-all-breakpoints=true]').click(function(){
        $(this).hide();
        $('[data-advanced-breakpoint=true]').show();
      });
    }
  };

$(function(){ flexible_content_breakpoints.init(); });

var flexible_content_breakpoints = flexible_content_breakpoints || {
    init: function() {
      $('a[data-show-all-breakpoints=true]').click(function(){
        flexible_content_breakpoints.show_all_breakpoints();
      });

      $('[data-default-breakpoint] select').change(function(){
        flexible_content_breakpoints.adjust_widths();
      });
    },

    show_all_breakpoints: function() {
      var label = $('[data-default-breakpoint=true] label');
      label.text(label.text() + ' (medium)');

      $('a[data-show-all-breakpoints=true]').hide();
      $('[data-advanced-breakpoint=true]').show();
    },

    adjust_widths: function() {
    }
  };

$(function(){ flexible_content_breakpoints.init(); });

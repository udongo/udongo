var seo = {
  vars: {
    slug_input: null
  },

  init: function() {
    seo.vars.slug_input = $('input[id*="seo_slug"]');
    seo.vars.slug_input.each(seo.slug_key_listener);
    seo.vars.slug_input.on('keyup', seo.slug_key_listener);
    if(seo.vars.slug_input.data('trigger')) {
      $('#'+ seo.vars.slug_input.data('trigger')).on('keyup', seo.trigger_key_listener);
    }
  },

  slug_key_listener: function(e) {
    var self = $(this);

    if(self.val() == '') {
      seo.help_block(self).text(seo.vars.slug_input.data('host-url'));
    }

    if(self.val().match(/^[a-z0-9-\/:]+$/)) {
      seo.help_block(self).text(self.data('host-url') + self.val());
    } else {
      if(self.val().slice(-1) == '/') {
        self.val(self.val().slice(0, -1));
      }
    }
  },

  trigger_key_listener: function(e) {
    if(seo.vars.slug_input.attr('disabled')) return;

    $.ajax({
      url: seo.vars.slug_input.data('slugify-path'),
      data: { value: $(this).val() },
      type: 'POST'
    }).done(function(data){
      seo.vars.slug_input.val(data.result);
      seo.vars.slug_input.each(seo.slug_key_listener);
    });
  },

  // Helpers

  help_block: function(input) {
    return input.siblings('.help.host');
  }
};

$(function(){ seo.init(); });

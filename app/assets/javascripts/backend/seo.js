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
    var input = $(this);

    if(input.val() == '') {
      seo.help_block(input).text(seo.vars.slug_input.data('host-url'));
    }

    if(input.val().match(/^[a-z0-9-\/:]+$/)) {
      seo.help_block(input).text(input.data('host-url') + input.val());
    } else {
      if(input.val().slice(-1) == '/') {
        input.val(input.val().slice(0, -1));
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
    return input.siblings('.hint');
  }
};

$(function(){ seo.init(); });

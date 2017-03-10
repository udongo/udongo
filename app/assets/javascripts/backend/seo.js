var seo = {
  init: function() {
    this.sluggable_input().on('keyup', $.debounce(1000, this.keyup_listener));
  },

  data: function(key) {
    return $('[data-seo]').data(key);
  },

  keyup_listener: function(e) {
    if(seo.slug_input().attr('disabled')) return;

    $.ajax({
      url: seo.data('path'),
      data: { value: $(this).val() },
      type: 'GET'
    }).done(function(data){
      seo.slug_input().val(data.result);
    });
  },

  slug_input: function() {
    return $('input[id*="seo_slug"]');
  },

  sluggable_input: function() {
    return $($('[data-seo]').data('sluggable-input'));
  }
};

$(function(){ seo.init(); });

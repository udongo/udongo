var seo = {
  init: function() {
    if(!seo.data('empty-slug')) return;
    this.sluggable_input().on('keydown', this.keydown_listener);
    this.sluggable_input().on('keyup', $.debounce(250, this.keyup_listener));
  },

  data: function(key) {
    return $('[data-seo]').data(key);
  },

  keydown_listener: function(e) {
    if(e.keyCode == 13) e.preventDefault();
  },

  keyup_listener: function(e) {
    if(seo.slug_input().attr('disabled')) return;
    var input = $(this);

    $.ajax({
      url: seo.data('path'),
      data: { value: input.val() },
      type: 'GET'
    }).done(function(data){
      seo.slug_input().val(data.result);
      if(e.keyCode == 13) input.parents('form').submit();
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

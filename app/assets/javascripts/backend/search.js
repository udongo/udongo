var search = search || {
  init: function() {
    this.target().autocomplete({
      minLength: 2,
      source: search.target().parents('form').attr('action'),
      select: search.select
    }).on('keypress', this.keypress_listener);

    this.target().data('ui-autocomplete')._renderItem = function(ul, item) {
      return $('<li></li>').data("item.autocomplete", item)
        .append(item.label)
        .appendTo(ul);
    };
  },

  keypress_listener: function(e) {
    var code = (e.keyCode ? e.keyCode : e.which);
    if(code == 13) return false;
  },

  select: function(event, ui) {
    window.location = ui.item.value;
    return false;
  },

  target: function() {
    return $('#search input');
  }
};

$(function(){ search.init(); });

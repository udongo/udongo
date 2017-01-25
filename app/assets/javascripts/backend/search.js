var search = search || {
  init: function() {
    this.target().autocomplete({
      minLength: 2,
      source: search.target().parents('form').attr('action'),
      focus: search.focus,
      select: search.select
    }).on('keypress', this.keypress_listener);
  },

  focus: function(event, ui) {
    console.log(ui);
    $(event.target).val(ui.item.label);
    return false;
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

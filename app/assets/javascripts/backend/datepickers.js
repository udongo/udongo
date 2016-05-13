var datepickers = datepickers || {
  init: function() {
    this.load_ranges();
    this.load_regulars();
    $('.date_picker, .date_range_picker').find('.input-group-addon').on(
      'click',
      this.icon_click_listener
    );
  },

  icon_click_listener: function(e) {
    e.preventDefault();
    $(this).parents('.input-group').find('input').trigger('focus');
  },

  load_ranges: function() {
    if(typeof this.starts_on === 'undefined' || typeof this.stops_on === 'undefined') return;

    this.starts_on().datepicker().on('changeDate', this.starts_on_change_date_listener);
    this.stops_on().datepicker({
      weekStart: 1,
      autoclose: true
    }).on('changeDate', this.stops_on_change_date_listener);
  },

  load_regulars: function() {
    var inputs = $('.date_picker input');
    if(typeof inputs.datepicker !== 'function') return;
    inputs.datepicker();
  },

  starts_on: function() {
    return $('.date_range_picker input[data-start]');
  },

  starts_on_change_date_listener: function(selected) {
    var date = new Date(selected.date.valueOf());
    date.setDate(date.getDate(new Date(selected.date.valueOf())));
    datepickers.stops_on().datepicker('setStartDate', date);
  },

  stops_on: function() {
    return $('.date_range_picker input[data-stop]');
  },

  stops_on_change_date_listener: function(selected) {
    var date = new Date(selected.date.valueOf());
    date.setDate(date.getDate(new Date(selected.date.valueOf())));
    datepickers.starts_on().datepicker('setEndDate', date);
  }
};

$(function(){ datepickers.init(); });

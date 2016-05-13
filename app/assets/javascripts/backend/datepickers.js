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

    $('.date_range_picker input').each(function(){
      var input = $(this);

      if(input.data('start') !== null) {
        datepickers.starts_on(input.data('start')).datepicker().on(
          'changeDate',
          datepickers.starts_on_change_date_listener
        );
      }

      if(input.data('stop') !== null) {
        datepickers.stops_on(input.data('stop')).datepicker({
          weekStart: 1,
          autoclose: true
        }).on('changeDate', datepickers.stops_on_change_date_listener);
      }
    });
  },

  load_regulars: function() {
    var inputs = $('.date_picker input');
    if(typeof inputs.datepicker !== 'function') return;
    inputs.datepicker();
  },

  starts_on: function(id) {
    return $('.date_range_picker input[data-start="'+ id +'"]');
  },

  starts_on_change_date_listener: function(selected) {
    var input = $(this);
    var date = new Date(selected.date.valueOf());
    date.setDate(date.getDate(new Date(selected.date.valueOf())));
    datepickers.stops_on(input.data('start')).datepicker('setStartDate', date);
  },

  stops_on: function(id) {
    return $('.date_range_picker input[data-stop="'+ id +'"]');
  },

  stops_on_change_date_listener: function(selected) {
    var input = $(this);
    var date = new Date(selected.date.valueOf());
    date.setDate(date.getDate(new Date(selected.date.valueOf())));
    datepickers.starts_on(input.data('stop')).datepicker('setEndDate', date);
  }
};

$(function(){ datepickers.init(); });

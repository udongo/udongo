var flexible_content = flexible_content || {
  init: function() {
    $('#content-rows').sortable({
      axis: 'y',
      handle: '.card-header',
      update: flexible_content.update_row_position_listener
    });

    $('.content-columns').sortable({
      axis: 'x',
      handle: '.card-header',
      update: flexible_content.update_column_position_listener
    })
  },

  update_column_position_listener: function(e, ui) {
    var new_position = ui.item.index() + 1

    $.ajax({
      data: { position: new_position },
      url: ui.item.data('update-position'),
      type: 'POST'
    });
  },

  update_row_position_listener: function(e, ui) {
    var new_position = ui.item.index() + 1

    $.ajax({
      data: { position: new_position },
      url: ui.item.data('update-position'),
      type: 'POST'
    });
  }
}

$(function(){ flexible_content.init(); });

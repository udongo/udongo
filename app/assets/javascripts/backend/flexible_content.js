var flexible_content = flexible_content || {
  init: function() {
    $('[id^=content-row-] > .row').sortable({
      handle: '.card',
      update: flexible_content.update_column_position_listener
    })
  },

  update_column_position_listener: function(e, ui) {
    var new_position = ui.item.index() + 1

    $.ajax({
      data: { position: new_position },
      url: ui.item.find('[data-update-position]').data('update-position'),
      type: 'POST'
    });
  },
}

$(function(){ flexible_content.init(); });

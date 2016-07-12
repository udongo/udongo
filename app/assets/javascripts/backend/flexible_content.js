var flexible_content = flexible_content || {
  init: function() {
    $('#content-rows').sortable({
      axis: 'y',
      handle: '.card-header',
      update: sortable.update_position_listener,
      placeholder: 'row-placeholder',
      tolerance: 'pointer',
      start: function(e, ui){
        ui.placeholder.height(ui.item.height());
        ui.placeholder.css('margin-bottom', ui.item.css('margin-bottom'));
      }
    });

    $('.content-columns').sortable({
      axis: 'x',
      handle: '.card',
      update: sortable.update_position_listener
    })
  }
}

$(function(){ flexible_content.init(); });

var flexible_content = flexible_content || {
  init: function() {
    $('#content-rows').sortable({
      axis: 'y',
      tolerance: 'pointer',
      handle: '.card-header',
      update: sortable.update_position_listener
    });

    $('.content-columns').sortable({
      axis: 'x',
      handle: '.card-header',
      update: sortable.update_position_listener
    })
  }
}

$(function(){ flexible_content.init(); });

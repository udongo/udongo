var flexible_content = flexible_content || {
  init: function() {
    $('#content-rows').sortable({
      axis: 'y',
      handle: '.card-header',
      update: sortable.update_position_listener,
      tolerance: 'pointer',
      placeholder: 'placeholder',
      start: function(e, ui){
        ui.placeholder.height(ui.item.height());
        ui.placeholder.css('margin-bottom', ui.item.css('margin-bottom'));
      }
    });

    $('.content-columns').sortable({
      axis: 'x',
      handle: '.card',
      update: sortable.update_position_listener,
      tolerance: 'pointer',
      placeholder: 'placeholder',
      start: function(e, ui){
        var classes = ui.item.attr('class').replace('content-column ') + ' placeholder';
        ui.placeholder.attr('class', classes);
        ui.placeholder.height(ui.item.find('.card').height());
        ui.placeholder.width(ui.item.find('.card').width() - 30);
        ui.placeholder.css('margin-left', '15px');
        ui.placeholder.css('margin-right', '15px');
      }
    })
  }
}

$(function(){ flexible_content.init(); });

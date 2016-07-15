var sortable = sortable || {
  init: function() {
    $('table tbody').each(function(){
      var tbody = $(this);

      if(tbody.find('tr[data-update-position]').length > 0) {
        sortable.load_on_tbody(tbody);
      }
    });
  },

  load_on_tbody: function(tbody) {
    sortable.generate_handle(tbody);

    tbody.sortable({
      handle: 'td.handle',
      update: sortable.update_position_listener
    });
  },

  generate_handle: function(tbody) {
    tbody.siblings('thead').find('tr th:first').before('<th></th>');
    tbody.find('tr[data-update-position]').each(function(){
      $(this).find('td:first').before(sortable.handle_html());
    });
  },

  update_position_listener: function(e, ui) {
    var new_position = ui.item.index() + 1

    $.ajax({
      data: { position: new_position },
      url: ui.item.data('update-position'),
      type: 'POST'
    });
  },

  handle_html: function() {
    html = '<td class="handle">';
    html += '  <a href="#"><span class="fa fa-arrows"></span></a>';
    html += '</td>';
    return $(html);
  }
};

$(function(){ sortable.init(); });

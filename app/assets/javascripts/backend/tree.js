var tree = {
  vars: {
    container: null
  },

  init: function(selector) {
    tree.vars.container = $(selector);
    tree.grab_data();
  },

  grab_data: function() {
    $.ajax({
      url: tree.vars.container.data('source'),
      type: 'GET'
    }).done(function(data){
      tree.load(data);
    });
  },

  load: function(data) {
    tree.vars.container.jstree({
      core: tree.core_settings(data),
      types: tree.types(),
      plugins: ['contextmenu','dnd','json_data','types','ui','state','wholerow'],
      contextmenu: { items: tree.contextmenu_items }
    });

    tree.vars.container.on('select_node.jstree', tree.select_node_listener);
    $(document).on('dnd_stop.vakata', tree.dnd_stop_listener);
  },

  core_settings: function(data) {
    return {
      check_callback: tree.dnd_check_callback,
      multiple: false,
      data: data,
      expand_selected_onload: false,
      themes: {
        responsive: true,
        variant: 'large'
      }
    };
  },

  types: function() {
    return {
      default: {
        icon: 'fa fa-folder',
        children: true,
        valid_children: ['default', 'file']
      },
      file: {
        icon: 'fa fa-file-o',
        valid_children: ['file']
      }
    };
  },

  select_node_listener: function(e, result) {
    if(typeof result.event !== 'undefined') {
      if(result.event.which === 1) {
        window.location = result.node.data.url;
      }
    } else {
      result.instance.deselect_node(result.node);
    }
  },

  contextmenu_items: function(node) {
    return {
      remove: {
        separator_before: false,
        separator_after: false,
        label: 'Verwijderen',
        icon: 'fa fa-trash',
        action: tree.contextmenu_remove_listener,
        _disabled: !node.data.deletable
      }
    };
  },

  contextmenu_remove_listener: function(obj) {
    var instance = tree.vars.container.jstree(true);
    var node = instance.get_node(obj.reference.prevObject.selector);

    $.ajax({
      data: { id: node.data.id },
      url: node.data.delete_url,
      type: 'DELETE'
    }).done(function(data){
      if(data.trashed) {
        obj.reference.prevObject.fadeOut(1000, function(){
          instance.delete_node(node);
        });
      }
    });
  },

  dnd_check_callback: function(operation, node, node_parent, node_position, more) {
    if(operation === 'move_node') {
      // With this you can't move nodes above or below the referenced node.
      // I don't think there's another way around this.
      if(!node.data.draggable || (typeof more.ref !== 'undefined' && !more.ref.data.draggable)) {
        return false;
      }
    }

    return true;
  },

  dnd_stop_listener: function(e, result) {
    var instance = result.data.origin;
    var moved_node = instance.get_node(result.data.nodes[0]);

    $.ajax({
      data: {
        parent_id: tree.calculate_new_parent_id(instance, moved_node),
        position: tree.calculate_new_position(instance, moved_node)
      },
      url: moved_node.data.update_position_url,
      type: 'POST'
    }).done(function(data){
      if(data.moved) {
        instance.set_icon(moved_node, 'fa fa-check');
        tree.change_icon_color(moved_node, '#66aa66');

        setTimeout(function(){
          tree.change_icon_color(moved_node, 'inherit');
          instance.set_icon(moved_node, 'fa fa-file-o');
        }, 2000);
      }
    });
  },

  calculate_new_parent_id: function(instance, moved_node) {
    var parent_node = instance.get_node(moved_node.parent);

    if(typeof parent_node.data !== 'undefined') {
      return parent_node.data.id;
    } else {
      return null;
    }
  },

  calculate_new_position: function(instance, moved_node) {
    var result = [];

    $(instance.get_children_dom(moved_node.parent)).each(function(){
      result.push(instance.get_node($(this).attr('id')).data.id);
    });

    return result.indexOf(moved_node.data.id) + 1;
  },

  change_icon_color: function(jstree_node, color) {
    $('#'+ jstree_node.id).find('.jstree-icon').css('color', color);
  }
};

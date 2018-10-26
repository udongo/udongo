var redirects = redirects || {
  trigger_button: null,
  containers: null,

  init: function() {
    $('#test-redirect-modal').on('shown.bs.modal', function() {
      redirects.trigger_button = $('#test-redirects');
      redirects.prepare_containers();
      redirects.trigger_button.off('click').on('click', redirects.trigger_button_click_listener);
    });
  },

  mark_card_as_processing: function(card) {
    card.removeClass('alert-danger');
    card.removeClass('alert-success');
    card.removeClass('alert-info');
    card.addClass('alert-warning');
    card.find('.card-icon').attr('hidden', true);
    card.find('.spinner-icon').attr('hidden', false);
  },

  prepare_containers: function() {
    redirects.containers = $('article.redirect').toArray();
    redirects.trigger_button.removeClass('disabled');
    $('[data-toggle="tooltip"]').tooltip();
  },

  process_next_container: function() {
    var container = redirects.containers.shift();
    redirects.run_for_container($(container));
  },

  run_for_container: function(container) {
    var card = container.find('.card');
    redirects.mark_card_as_processing(card);

    // This fixes an issue with code somehow calling this method a fourth time
    // when there are only 3 items in this.containers.
    if(container.length == 0) return;

    $.ajax({
      url: container.data('path'),
      type: 'POST'
    }).done(function(data){
      redirects.process_next_container(container);
    });
  },

  trigger_button_click_listener: function(e) {
    e.preventDefault();
    var anchor = $(this);
    anchor.addClass('disabled');

    redirects.process_next_container();
  }
};

$(function(){ redirects.init(); });

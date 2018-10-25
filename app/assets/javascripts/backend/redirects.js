var redirects = {
  containers: null,

  init: function() {
    this.containers = $('article.redirect').toArray();
    $('#test-redirects').on('click', this.test_all_click_listener);
  },

  test_all_click_listener: function(e) {
    e.preventDefault();
    redirects.process_next_container();
  },

  mark_card_as_processing: function(card) {
    card.removeClass('alert-danger');
    card.removeClass('alert-success');
    card.removeClass('alert-info');
    card.addClass('alert-warning');
    card.find('.card-icon').attr('hidden', true);
    card.find('.spinner-icon').attr('hidden', false);
  },

  trigger_test_from_container: function(container) {
    var card = container.find('.card');
    redirects.mark_card_as_processing(card);

    $.ajax({
      url: container.data('path'),
      type: 'POST'
    }).done(function(data){
      redirects.process_next_container(container);
    });
  },

  process_next_container: function() {
    var container = redirects.containers.shift();
    redirects.trigger_test_from_container($(container));
  }
};

$(function(){ redirects.init(); });

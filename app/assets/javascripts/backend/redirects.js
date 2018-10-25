var redirects = {
  test_all_button: null,
  containers: null,

  init: function() {
    this.test_all_button = $('#test-redirects');
    this.prepare_containers();
    this.test_all_button.on('click', this.test_all_click_listener);
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
    setTimeout(function(){
      redirects.containers = $('article.redirect').toArray();
      redirects.test_all_button.removeClass('disabled');
      $('[data-toggle="tooltip"]').tooltip();
    }, 1000);
  },

  test_all_click_listener: function(e) {
    e.preventDefault();
    var anchor = $(this);
    anchor.addClass('disabled');

    redirects.process_next_container();
  },

  process_next_container: function() {
    var container = redirects.containers.shift();
    redirects.trigger_test_from_container($(container));
  },

  trigger_test_from_container: function(container) {
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
  }
};

$(function(){ redirects.init(); });

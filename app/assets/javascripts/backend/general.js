var general = general || {
  init: function() {
    $('form:not(.no-focus) input:visible:not(.no-focus):first').focus();
    $('[data-toggle="tooltip"]').tooltip();
    $('[href="#lity-close"]').on('click', this.lity_close_click_listener);
    this.bind_remote_content_for_bootstrap_modals();
  },

  bind_remote_content_for_bootstrap_modals: function() {
    $('[data-toggle="modal"]').on('click', function() {
      var anchor = $(this);
      $(anchor.data('target') + ' .modal-body').load(anchor.data('remote'));
    });
  },

  lity_close_click_listener: function(e) {
    e.preventDefault();
    $(parent.window.document).find('[data-lity-close=""]').trigger('click');
  }
};

$(function(){ general.init(); });

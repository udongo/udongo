module Backend::FormHelper
  def trigger_dirty_inputs_warning(message: I18n.t('b.msg.dirty_inputs_warning'))
    content_tag :span, message, class: 'hidden-xs-up', data: { dirty: false }
  end
end

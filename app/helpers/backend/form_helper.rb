module Backend::FormHelper
  def trigger_dirty_inputs_warning
    content_tag :span, t('b.msg.dirty_inputs_warning'), class: 'hidden-xs-up', data: { dirty: false }
  end
end

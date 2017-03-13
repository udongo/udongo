module Backend::FormHelper
  def trigger_dirty_inputs_warning
    content_tag :span, '', data: { dirty: true }
  end
end

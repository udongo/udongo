module Backend::FormHelper
  def trigger_dirty_inputs_warning
    content_tag :span, '', data: { dirty: false }
  end
end

module Backend::FormSubmissionHelper
  def information_list(submission)
    content_tag(:ul, class: 'list-unstyled') do
      Udongo.config.form_datagrid_fields.map do |field|
        value = submission.data_object.send(field)
        concat(content_tag(:li, "#{I18n.t("b.#{field}")}: #{value}"))
      end
    end
  end
end

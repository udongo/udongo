module Backend::FormSubmissionHelper
  # TODO: Do try and put this in a decorator
  def datagrid_column_values(form, submission)
    config = Udongo.config.form_submissions[form.identifier.to_sym]
    return nil if config.blank?

    config[:datagrid_fields].map do |field|
      content_tag(:td, submission.data_object.send(field))
    end.join("\n").html_safe
  end

  def datagrid_column_headers(form, filter)
    config = Udongo.config.form_submissions[form.identifier.to_sym]
    return nil if config.blank?

    config[:datagrid_fields].map do |field|
      content_tag(:th, t("b.#{field}"))
    end.join("\n").html_safe
  end
end

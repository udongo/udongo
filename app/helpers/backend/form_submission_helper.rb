module Backend::FormSubmissionHelper
  # TODO: Do try and put this in a decorator
  def datagrid_column_values(form, submission)
    fields = Udongo.config.form_datagrid_fields[form.identifier.to_sym]
    return nil if fields.blank?

    fields.map do |field|
      content_tag(:td, submission.data_object.send(field))
    end.join("\n").html_safe
  end

  def datagrid_column_headers(form, filter)
    fields = Udongo.config.form_datagrid_fields[form.identifier.to_sym]
    return nil if fields.blank?

    fields.map do |field|
      content_tag(:th, "data_#{field}", t("b.#{field}"))
    end.join("\n").html_safe
  end
end

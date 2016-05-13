class DatePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_table
    end
  end

  def data_attributes
    attributes = {}
    attributes.reverse_merge!(
      date_language: I18n.locale,
      date_format: 'dd/mm/yyyy'
    )
  end

  def icon_table
    template.content_tag(:span, '', class: 'fa fa-th')
  end

  def input_html_options
    super.merge(class: 'form-control', readonly: true, data: data_attributes)
  end

  def span_table
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_table
    end
  end
end

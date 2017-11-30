class ButtonRadiosInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    template.content_tag :div, class: 'btn-group', data: { toggle: 'buttons' } do
      string = ''

      input_options[:collection].each do |value|
        string << template.content_tag(:label, class: 'btn btn-primary') do
          content = template.radio_button_tag("#{object.model_name.i18n_key}[#{attribute_name}]", value, checked: true)
          content << template.t("simple_form.labels.#{object.model_name.i18n_key}.#{value}")
          content
        end
      end

      string.html_safe
    end
  end
end

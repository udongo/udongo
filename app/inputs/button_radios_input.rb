class ButtonRadiosInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    template.content_tag :div, class: 'btn-group', data: { toggle: 'buttons' } do
      string = ''

      input_options[:collection].each do |value|
        active = object.send(attribute_name) == value.to_s

        string << template.content_tag(:label, class: "btn btn-primary #{'active' if active}", data: { target: ".#{object_name}_#{value}" }) do
          content = template.radio_button_tag("#{object_name}[#{attribute_name}]", value, active)
          content << template.t("simple_form.labels.#{object_name}.#{value}")
          content
        end
      end

      string.html_safe
    end
  end
end

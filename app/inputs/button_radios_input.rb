class ButtonRadiosInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    template.content_tag :div, wrapper_options do
      string = ''

      input_options[:collection].each do |value|
        active = object.send(attribute_name) == value.to_s

        string << template.content_tag(:label, class: "btn btn-primary #{'active' if active}", data: { target: "[data-#{object_name}-#{value}]".gsub('_', '-') }) do
          content = @builder.radio_button(attribute_name, value, input_html_options)
          content << template.t("simple_form.labels.#{object_name}.#{value}")
          content
        end
      end

      string.html_safe
    end
  end
end

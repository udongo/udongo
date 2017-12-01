class ButtonRadiosInput < SimpleForm::Inputs::Base
  def collection_item_active?(value)
    object.send(attribute_name) == value.to_s
  end

  def collection_item_input_element(value)
    template.content_tag(:label, label_html_options_for_collection_item(value)) do
      content = @builder.radio_button(attribute_name, value, input_html_options)
      content << label_text_for_collection_item(value)
      content
    end
  end

  def input(wrapper_options = nil)
    template.content_tag :div, wrapper_options do
      input_options[:collection].inject('') do |stack, value|
        stack << collection_item_input_element(value)
      end.html_safe
    end
  end

  def label_data_target(value)
    "#{object_name}-#{attribute_name}-#{value}".gsub('_', '-').html_safe
  end

  # This represents the HTML attributes for the label containing the actual
  # radiobutton of one button_radios collection item. An example:
  #
  #   f.input(:toggle, as: :button_radios, collection: [:foo, :bar])
  #
  # With one collection item, I mean an input representing either :foo or :bar.
  #
  def label_html_options_for_collection_item(value)
    label_html_options.merge!(
      class: "btn btn-primary #{'active' if collection_item_active?(value)}",
      data: { target: label_data_target(value) }
    )
  end

  def label_text_for_collection_item(value)
    template.t("simple_form.labels.#{object_name}.#{value}")
  end
end

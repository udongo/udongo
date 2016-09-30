require 'simple_form'

module Trix
  module Hooks
    module SimpleForm
      class TrixInput < ::SimpleForm::Inputs::Base
        def input(_wrapper_options = nil)
          content = @builder.input(attribute_name, as: 'hidden')
          content << content_tag(:'trix-editor', nil, input: trix_input_name)
          content
        end

        def trix_input_name
          "#{object_name}_#{attribute_name}"
        end
      end
    end
  end
end

::SimpleForm::FormBuilder.map_type :trix_editor, to: Trix::Hooks::SimpleForm::TrixInput

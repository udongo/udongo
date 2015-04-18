require 'rails_helper'

shared_examples_for :translatable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:translation)
  end

  it '.respond_to?' do
    expect(model).to respond_to(
      :translatable_field, :translatable_fields, :translation_config
    )
  end
end

require 'rails_helper'

describe FormFieldValidation do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:form_field) { expect(build(klass, form_field: nil)).not_to be_valid }
      it(:validation_class) { expect(build(klass, validation_class: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form_field)
  end
end

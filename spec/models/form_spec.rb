require 'rails_helper'

describe Form do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:identifier) { expect(build(klass, identifier: nil)).to_not be_valid }
    end
  end

  it 'translatable' do
    expect(model.translation_config.fields).to eq [:success_message]
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:fields, :submissions)
  end
end

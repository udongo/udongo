require 'rails_helper'

describe Form do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:description) { expect(build(klass, description: nil)).to_not be_valid }
    end
  end

  it 'translatable' do
    expect(described_class.translatable_fields_list).to eq [:success_message]
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:fields, :submissions, :data)
  end
end

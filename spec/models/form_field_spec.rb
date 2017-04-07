require 'rails_helper'

describe FormField do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :sortable
  it_behaves_like :translatable

  describe 'validations' do
    describe 'presence' do
      it(:form) { expect(build(klass, form: nil)).not_to be_valid }
      it(:name) { expect(build(klass, name: nil)).not_to be_valid }
      it(:field_type) { expect(build(klass, field_type: nil)).not_to be_valid }
    end
  end

  it 'translatable' do
    expect(described_class.translatable_fields_list).to eq [:label, :default_value, :placeholder]
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form)
  end
end

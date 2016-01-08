require 'rails_helper'

describe Store do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:name) { expect(build(klass, name: nil)).not_to be_valid }
      it(:klass) { expect(build(klass, klass: nil)).not_to be_valid }
    end

    it 'unique name scoped on storable_type and storable_id' do
      create(klass, storable_type: 'Page', storable_id: 1, name: 'foo')
      expect(build(klass, storable_type: 'Page', storable_id: 1, name: 'FOO')).not_to be_valid
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:storable)
  end
end


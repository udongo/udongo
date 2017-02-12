require 'rails_helper'

describe SearchModule do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:name) { expect(build(klass, name: nil)).to_not be_valid }
    end
  end

  describe 'scopes' do
    it '.weighted' do
      a = create(klass, name: 'Foo', weight: 5)
      b = create(klass, name: 'Bar', weight: 10)
      c = create(klass, name: 'Baz', weight: 1)
      expect(described_class.weighted).to eq [b, a, c]
    end
  end

  describe '#indices' do
    it 'default' do
      expect(build(klass).indices).to eq []
    end

    it 'filters from other modules' do
      instance = create(klass, name: 'Foo')
      a = create(:search_index, searchable_type: 'Foo', searchable_id: 1)
      b = create(:search_index, searchable_type: 'Bar', searchable_id: 1)
      c = create(:search_index, searchable_type: 'Foo', searchable_id: 2)
      expect(instance.indices).to eq [a, c]
    end
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(
      :indices
    )
  end
end

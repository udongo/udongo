require 'rails_helper'

describe Udongo::Search do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:instance) { described_class.new('foo') }

  describe '#find' do
    # TODO:
  end

  describe '#indices' do
    it 'default' do
      expect(instance.indices).to eq []
    end

    it 'returns results sorted by SearchModule weight' do
      create(:search_module, name: 'Foo', weight: 1)
      create(:search_module, name: 'Bar', weight: 10)
      create(:search_module, name: 'Baz', weight: 5)

      a = create(:search_index, searchable_type: 'Bar', searchable_id: 1)
      b = create(:search_index, searchable_type: 'Bar', searchable_id: 2)
      c = create(:search_index, searchable_type: 'Foo', searchable_id: 5)
      d = create(:search_index, searchable_type: 'Foo', searchable_id: 8)
      e = create(:search_index, searchable_type: 'Baz', searchable_id: 18)
      expect(instance.indices).to eq [a, b, e, c, d]
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :find, :indices
    )
  end
end

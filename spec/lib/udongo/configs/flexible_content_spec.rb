require 'rails_helper'

describe Udongo::Configs::FlexibleContent do
  let(:instance) { described_class.new }

  describe 'defaults' do
    it :allowed_column_dimensions do
      expect(instance.allowed_column_dimensions).to eq %w(xs sm md lg xl)
    end

    it :types do
      expect(instance.types).to eq %w(text image)
    end
  end

  describe '#column_dimension_allowed?' do
    it 'true' do
      allow(instance).to receive(:allowed_column_dimensions) { %w(xs sm md lg xl) }
      expect(instance.column_dimension_allowed?(:sm)).to be true
    end

    it 'false' do
      allow(instance).to receive(:allowed_column_dimensions) { %w(xs) }
      expect(instance.column_dimension_allowed?(:sm)).to be false
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :types, :types=, :allowed_column_dimensions, :allowed_column_dimensions=,
      :column_dimension_allowed?
    )
  end
end

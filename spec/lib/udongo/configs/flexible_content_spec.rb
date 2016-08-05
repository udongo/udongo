require 'rails_helper'

describe Udongo::Configs::FlexibleContent do
  let(:instance) { described_class.new }

  describe 'defaults' do
    it :allowed_column_widths do
      expect(instance.allowed_column_widths).to eq %w(xs sm md lg xl)
    end

    it :types do
      expect(instance.types).to eq %w(text image)
    end
  end

  describe '#column_width_allowed?' do
    it 'true' do
      allow(instance).to receive(:allowed_column_widths) { %w(xs sm md lg xl) }
      expect(instance.column_width_allowed?(:sm)).to be true
    end

    it 'false' do
      allow(instance).to receive(:allowed_column_widths) { %w(xs) }
      expect(instance.column_width_allowed?(:sm)).to be false
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :types, :types=, :allowed_column_widths, :allowed_column_widths=,
      :column_width_allowed?
    )
  end
end

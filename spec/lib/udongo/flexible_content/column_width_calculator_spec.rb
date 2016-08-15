require 'rails_helper'

describe Udongo::FlexibleContent::ColumnWidthCalculator do
  let(:row) { create(:content_row) }
  let(:instance) { described_class.new(row) }

  before(:each) do
    create(:content_column, row: row, width_xs: 12, width_sm: 12, width_md: 6, width_lg: 6, width_xl: 8)
  end

  it '#hashed_values' do
    expect(instance.hashed_values).to eq({ width_xs: 12, width_sm: 12, width_md: 6, width_lg: 6, width_xl: 4 })
  end

  describe '#calculate' do
    it 'default' do
      expect(instance.calculate(:width_sm)).to eq 12
    end

    it 'defaults to 12 for XS' do
      allow(instance).to receive(:total).with(:width_xs) { 5 }
      expect(instance.calculate(:width_xs)).to eq 12
    end

    it 'defaults to 12 for SM' do
      allow(instance).to receive(:total).with(:width_sm) { 5 }
      expect(instance.calculate(:width_sm)).to eq 12
    end

    it 'column set' do
      expect(instance.calculate(:width_xl)).to eq 4
    end
  end

  describe '#total' do
    it 'default' do
      ContentColumn.destroy_all
      expect(instance.total(:width_xs)).to eq 0
    end

    it '> 12 becomes 12' do
      create(:content_column, row: row, width_xs: 12, width_sm: 12, width_md: 3, width_lg: 3, width_xl: 2)
      expect(instance.total(:width_xs)).to eq 12
    end

    it 'makes sum of column values' do
      create(:content_column, row: row, width_xs: 12, width_sm: 12, width_md: 3, width_lg: 3, width_xl: 2)
      expect(instance.total(:width_lg)).to eq 9
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :hashed_values, :calculate, :total
    )
  end
end

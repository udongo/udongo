require 'rails_helper'

describe ContentRowDecorator do
  let(:content_row) { build(:content_row) }
  let(:instance) { content_row.decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }

  describe '#column_limit_reached?' do
    it 'true' do
      create(:content_column, row: content_row, width_xl: 6)
      create(:content_column, row: content_row, width_xl: 6)
      expect(instance.column_limit_reached?).to be true
    end

    it 'false' do
      create(:content_column, row: content_row, width_xl: 6)
      expect(instance.column_limit_reached?).to be false
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:column_limit_reached?)
  end
end

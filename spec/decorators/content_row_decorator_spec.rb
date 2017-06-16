require 'rails_helper'

describe ContentRowDecorator do
  let(:content_row) { build(:content_row) }
  let(:instance) { content_row.decorate }
  it(:decorated?) { expect(instance).to be_decorated_with described_class }

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

  describe '#classes' do
    it 'horizontal: blank' do
      row = create(:content_row, horizontal_alignment: '').decorate
      expect(row.classes).to eq []
    end

    it 'horizontal: left' do
      row = create(:content_row, horizontal_alignment: 'left').decorate
      expect(row.classes).to eq []
    end

    it 'horizontal: center' do
      row = create(:content_row, horizontal_alignment: 'center').decorate
      expect(row.classes).to eq %w(justify-content-center)
    end

    it 'horizontal: right' do
      row = create(:content_row, horizontal_alignment: 'right').decorate
      expect(row.classes).to eq %w(justify-content-end)
    end

    it 'vertical: blank' do
      row = create(:content_row, vertical_alignment: '').decorate
      expect(row.classes).to eq []
    end

    it 'vertical: top' do
      row = create(:content_row, vertical_alignment: 'top').decorate
      expect(row.classes).to eq []
    end

    it 'vertical: center' do
      row = create(:content_row, vertical_alignment: 'center').decorate
      expect(row.classes).to eq %w(align-items-center)
    end

    it 'vertical: bottom' do
      row = create(:content_row, vertical_alignment: 'bottom').decorate
      expect(row.classes).to eq %w(align-items-end)
    end

    it 'horizontal: center, vertical: center' do
      row = create(
        :content_row,
        horizontal_alignment: 'center',
        vertical_alignment: 'center'
      ).decorate
      expect(row.classes).to eq %w(justify-content-center align-items-center)
    end
  end

  describe '#styles' do
    it :none do
      row = create(:content_row).decorate
      expect(row.styles).to eq({})
    end

    it :background_color do
      row = create(:content_row, background_color: '#336699').decorate
      expect(row.styles).to eq({ 'background-color': '#336699' })
    end

    it :margin_top do
      row = create(:content_row, margin_top: 1).decorate
      expect(row.styles).to eq({ 'margin-top': 1 })
    end

    it :margin_bottom do
      row = create(:content_row, margin_bottom: 1).decorate
      expect(row.styles).to eq({ 'margin-bottom': 1 })
    end

    it :padding_top do
      row = create(:content_row, padding_top: 1).decorate
      expect(row.styles).to eq({ 'padding-top': 1 })
    end

    it :padding_bottom do
      row = create(:content_row, padding_bottom: 1).decorate
      expect(row.styles).to eq({ 'padding-bottom': 1 })
    end

    it 'all combined' do
      row = create(
        :content_row,
        background_color: '#336699',
        margin_top: 1,
        margin_bottom: 1,
        padding_top: 1,
        padding_bottom: 1
      ).decorate
      expect(row.styles).to eq(
                              {
                                'background-color': '#336699',
                                'margin-top': 1,
                                'margin-bottom': 1,
                                'padding-top': 1,
                                'padding-bottom': 1
                              }
                            )
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:column_limit_reached?, :classes)
  end
end

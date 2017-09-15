require 'rails_helper'

describe Udongo::FlexibleContent::DuplicateLocale do
  describe '#execute!' do
    it 'object has no content rows' do
      instance = described_class.new(Class.new, :nl, :en)
      expect { instance.execute! }.to raise_error(RuntimeError).with_message('The object you provided does not have the FlexibleContent concern included.')
    end

    it 'source and destination locale are the same' do
      instance = described_class.new(Page.new, :nl, 'nl')
      expect { instance.execute! }.to raise_error(RuntimeError).with_message('The source and destination locale are the same (nl)')
    end

    it 'deletes the current content from the destination locale' do
      page = create(:page)
      page.content_rows.create!(locale: 'en')

      described_class.new(page, :nl, :en).execute!

      expect(page.content_rows.by_locale(:en).count).to be_zero
    end

    describe 'copies the content' do
      it 'copies the rows' do
        page = create(:page)
        page.content_rows.create!(locale: 'nl')
        page.content_rows.create!(
          locale: 'nl',
          full_width: true,
          horizontal_alignment: 'center',
          vertical_alignment: 'center',
          background_color: '#336699',
          no_gutters: true,
          padding_top: 1,
          padding_bottom: 2,
          margin_top: 3,
          margin_bottom: 4
        )

        described_class.new(page, :nl, :en).execute!

        expect(page.content_rows.by_locale(:en).count).to eq 2

        first_row = page.content_rows.by_locale(:en).first
        expect(first_row).not_to be_full_width
        expect(first_row.horizontal_alignment).to eq nil
        expect(first_row.vertical_alignment).to eq nil
        expect(first_row.background_color).to eq nil
        expect(first_row).not_to be_no_gutters
        expect(first_row.padding_top).to eq nil
        expect(first_row.padding_bottom).to eq nil
        expect(first_row.margin_top).to eq nil
        expect(first_row.margin_bottom).to eq nil
        expect(first_row.position).to eq 1

        second_row = page.content_rows.by_locale(:en).last
        puts second_row.inspect
        expect(second_row).to be_full_width
        expect(second_row.horizontal_alignment).to eq 'center'
        expect(second_row.vertical_alignment).to eq 'center'
        expect(second_row.background_color).to eq '#336699'
        expect(second_row).to be_no_gutters
        expect(second_row.padding_top).to eq 1
        expect(second_row.padding_bottom).to eq 2
        expect(second_row.margin_top).to eq 3
        expect(second_row.margin_bottom).to eq 4
        expect(second_row.position).to eq 2
      end

      describe 'copies the columns' do
        it 'text widget' do
        end

        it 'picture widget' do
        end

        it 'video widget' do
        end

        it 'slideshow widget' do
        end

        it 'form widget' do
        end
      end
    end
  end

  it '#respond_to?' do
    expect(described_class.new(nil, nil, nil)).to respond_to(:execute!)
  end
end

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
        page.content_rows << create(:content_row, locale: 'nl')
        page.content_rows << create(
          :content_row,
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
        it 'check the column' do
          widget = create(:content_text, content: 'foo')

          page = create(:page)
          page.content_rows << create(:content_row, locale: 'nl')

          row = page.content_rows.by_locale(:nl).first
          row.columns << create(
            :content_column,
            content_type: widget.class,
            content_id: widget.id
          )
          original_column = row.columns.first

          described_class.new(page, :nl, :en).execute!

          column =  page.content_rows.by_locale(:en).first.columns.first
          expect(column.width_md).to eq original_column.width_md
          expect(column.width_lg).to eq original_column.width_lg
          expect(column.width_xl).to eq original_column.width_xl
          expect(column.width_sm).to eq original_column.width_sm
          expect(column.width_xs).to eq original_column.width_xs
          expect(column.position).to eq original_column.position
          expect(column.content_type).to eq original_column.content_type
          expect(column.content_id).not_to be_nil
          expect(column.content_id).not_to eq nil
        end

        it 'text widget' do
          widget = create(:content_text, content: 'foo')

          page = create(:page)
          page.content_rows << create(:content_row, locale: 'nl')

          row = page.content_rows.by_locale(:nl).first
          row.columns << create(:content_column, content_type: widget.class, content_id: widget.id)

          described_class.new(page, :nl, :en).execute!

          column =  page.content_rows.by_locale(:en).first.columns.first

          expect(column.content.class).to eq widget.class
          expect(column.content.id).not_to eq widget.id
          expect(column.content.content).to eq 'foo'
        end

        it 'picture widget' do
          widget = create(:content_picture, caption: 'foo', url: 'bar')

          page = create(:page)
          page.content_rows << create(:content_row, locale: 'nl')

          row = page.content_rows.by_locale(:nl).first
          row.columns << create(:content_column, content_type: widget.class, content_id: widget.id)

          described_class.new(page, :nl, :en).execute!

          column =  page.content_rows.by_locale(:en).first.columns.first

          expect(column.content.class).to eq widget.class
          expect(column.content.id).not_to eq widget.id
          expect(column.content.asset).to eq widget.asset
          expect(column.content.caption).to eq 'foo'
          expect(column.content.url).to eq 'bar'
        end

        it 'video widget' do
          widget = create(:content_video, url: 'foo', caption: 'bar', aspect_ratio: '16x9')

          page = create(:page)
          page.content_rows << create(:content_row, locale: 'nl')

          row = page.content_rows.by_locale(:nl).first
          row.columns << create(:content_column, content_type: widget.class, content_id: widget.id)

          described_class.new(page, :nl, :en).execute!

          column =  page.content_rows.by_locale(:en).first.columns.first

          expect(column.content.class).to eq widget.class
          expect(column.content.id).not_to eq widget.id
          expect(column.content.url).to eq 'foo'
          expect(column.content.caption).to eq 'bar'
          expect(column.content.aspect_ratio).to eq '16x9'
        end

        it 'slideshow widget' do
          widget = create(:content_slideshow, autoplay: true, slide_interval: 4)

          page = create(:page)
          page.content_rows << create(:content_row, locale: 'nl')

          row = page.content_rows.by_locale(:nl).first
          row.columns << create(:content_column, content_type: widget.class, content_id: widget.id)

          described_class.new(page, :nl, :en).execute!

          column =  page.content_rows.by_locale(:en).first.columns.first

          expect(column.content.class).to eq widget.class
          expect(column.content.id).not_to eq widget.id
          expect(column.content.image_collection).to eq widget.image_collection
          expect(column.content.autoplay).to eq true
          expect(column.content.slide_interval).to eq 4
        end

        it 'form widget' do
          widget = create(:content_form)

          page = create(:page)
          page.content_rows << create(:content_row, locale: 'nl')

          row = page.content_rows.by_locale(:nl).first
          row.columns << create(:content_column, content_type: widget.class, content_id: widget.id)

          described_class.new(page, :nl, :en).execute!

          column =  page.content_rows.by_locale(:en).first.columns.first

          expect(column.content.class).to eq widget.class
          expect(column.content.id).not_to eq widget.id
        end
      end
    end
  end

  it '#respond_to?' do
    expect(described_class.new(nil, nil, nil)).to respond_to(:execute!)
  end
end

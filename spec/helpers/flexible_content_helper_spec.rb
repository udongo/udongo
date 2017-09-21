require 'rails_helper'

describe FlexibleContentHelper do
  describe '#importable_locales' do
    it 'skip the current locale' do
      page = create(:page)
      page.content_rows << create(:content_row, locale: 'nl')
      page.content_rows << create(:content_row, locale: 'en')

      expect(importable_locales(page, :fr)).to eq %w(nl en)
    end

    it 'skip the locales without content' do
      page = create(:page)
      page.content_rows << create(:content_row, locale: 'nl')

      expect(importable_locales(page, :fr)).to eq %w(nl)
    end
  end
end

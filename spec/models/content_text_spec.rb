require 'rails_helper'

describe ContentText do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '#column' do
    page = create(:page)
    page.content_rows << create(:content_row, rowable: page)
    row = page.content_rows.first
    text = create(klass)
    row.columns << create(:content_column, content_type: 'ContentText', content_id: text.id)

    expect(text.column).to eq row.columns.take
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:column)
  end
end

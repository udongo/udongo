require 'rails_helper'

shared_examples_for :content_type do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '#column' do
    page = create(:page)
    page.content_rows << create(:content_row, rowable: page)
    row = page.content_rows.first
    type = create(klass)
    row.columns << create(:content_column, content_type: type.class, content_id: type.id)

    expect(type.column).to eq row.columns.take
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:column, :parent, :content_type_is?)
  end
end

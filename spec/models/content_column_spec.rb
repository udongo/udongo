require 'rails_helper'

describe ContentColumn do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:row) { expect(build(klass, row: nil)).not_to be_valid }
      it(:width) { expect(build(klass, width: nil)).not_to be_valid }
    end
  end

  it :touch do
    column = create(klass)
    row_update_date = Time.zone.yesterday.to_date
    column.row.update_attribute(:updated_at, row_update_date)
    column.width = 11
    column.save
    expect(column.row.updated_at.to_date).to eq Date.today
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:row, :content)
  end
end

require 'rails_helper'
require "#{Udongo::PATH}/spec/support/concerns/sortable"

describe ContentRow do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable
  it_behaves_like :locale

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
    end
  end

  describe 'touch' do
    let(:yesterday) { Time.zone.yesterday.to_date }

    it :rowable do
      page = create(:page)
      page.update_attribute(:updated_at, yesterday)

      row = create(klass, rowable_type: 'Page', rowable_id: page.id)
      page.reload

      row.created_at = 2.weeks.ago
      row.save!

      expect(page.updated_at.to_date).to eq Date.today
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:rowable, :columns)
  end
end

require 'rails_helper'

describe Backend::NavigationItemForm do
  let(:klass) { described_class }
  let(:instance) { klass.new(create(:navigation).items.new) }

  describe '#save' do
    it 'create' do
      expect(instance.save({})).to eq true

      item = NavigationItem.first
      expect(item.page_id).to eq nil
      expect(item.extra).to eq nil
    end

    it 'update' do
      page = create(:page, id: 1)
      navigation_item = create(:navigation_item)

      expect(klass.new(navigation_item).save(
        page_id: 1,
        extra: 'foo'
      )).to eq true

      navigation_item = NavigationItem.first
      expect(navigation_item.page).to eq page
      expect(navigation_item.extra).to eq 'foo'
    end
  end

  describe '#persisted?' do
    it :true do
      navigation_item = create(:navigation_item)
      expect(klass.new(navigation_item)).to be_persisted
    end

    it :false do
      expect(klass.new(NavigationItem.new)).not_to be_persisted
    end
  end

  it '#respond_to' do
    expect(klass.new(NavigationItem.new)).to respond_to(:save, :persisted?, :navigation_item)
  end
end

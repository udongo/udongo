require 'rails_helper'

describe NavigationItemDecorator do
  describe '#label' do
    context 'page set' do
      it 'label set' do
        page = create(:page)
        page.translation(:nl).title = 'foo'
        page.translation(:nl).save

        item = create(:navigation_item, page: page)
        item.translation(:nl).label = 'bar'
        item.translation(:nl).save

        expect(item.decorate.label).to eq 'bar'
      end

      it 'no label set' do
        page = create(:page)
        page.translation(:nl).title = 'foo'
        page.translation(:nl).save

        item = create(:navigation_item, page: page)

        expect(item.decorate.label).to eq 'foo'
      end
    end

    context 'no page set' do
      it 'label set' do
        item = create(:navigation_item)
        item.translation(:nl).label = 'foo'
        item.translation(:nl).save

        expect(item.decorate.label).to eq 'foo'
      end

      it 'no label set' do
        item = create(:navigation_item)
        expect(item.decorate.label).to eq ''
      end
    end
  end
  it '#respond_to?' do
    expect(create(:navigation_item).decorate).to respond_to(:label, :path)
  end
end

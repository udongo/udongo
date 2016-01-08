require 'rails_helper'

describe NavigationItemDecorator do
  describe '#label' do
    context 'page set' do
      before(:each) do
        @page = create(:page)
        @page.translation(:nl).title = 'foo'
        @page.translation(:nl).save
      end

      it 'label set' do
        item = create(:navigation_item, page: @page)
        item.translation(:nl).label = 'bar'
        item.translation(:nl).save

        expect(item.decorate.label).to eq 'bar'
      end

      it 'no label set' do
        item = create(:navigation_item, page: @page)
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

  describe '#path' do
    context 'page set' do
      before(:each) do
        @page = create(:page)
        @page.translation(:nl).title = 'foo'
        @page.translation(:nl).save
      end

      it 'path set' do
        item = create(:navigation_item, page: @page)
        item.translation(:nl).path = 'bar'
        item.translation(:nl).save

        expect(item.decorate.path).to eq 'bar'
      end

      context 'path not set' do
        it 'page has route' do
          @page.route = 'backend_path'
          @page.save

          item = create(:navigation_item, page: @page)
          expect(item.decorate.path).to eq '/backend'
        end

        it 'page has no route' do
          item = create(:navigation_item, page: @page)
          expect(item.decorate.path).to eq '/nl/'
        end
      end
    end

    context 'no page set' do
      it 'path set' do
        item = create(:navigation_item, page: @page)
        item.translation(:nl).path = 'bar'
        item.translation(:nl).save

        expect(item.decorate.path).to eq 'bar'
      end

      it 'path not set' do
        item = create(:navigation_item, page: @page)
        expect(item.decorate.path).to eq '/'
      end
    end
  end

  it '#respond_to?' do
    expect(create(:navigation_item).decorate).to respond_to(:label, :path, :options_for_page)
  end
end

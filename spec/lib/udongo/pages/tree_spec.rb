require 'rails_helper'

describe Udongo::Pages::Tree do
  let(:route_context) { OpenStruct.new }
  let(:instance) { described_class.new(route_context) }

  describe '#data' do
    before(:each) do
      allow(route_context).to receive(:backend_page_path) { '/backend/pages/1' }
      allow(route_context).to receive(:edit_translation_backend_page_path) { '/backend/pages/1/edit/nl' }
      allow(route_context).to receive(:tree_drag_and_drop_backend_page_path) { '/backend/pages/1/tree_drag_and_drop' }
      allow(route_context).to receive(:toggle_visibility_backend_page_path) { '/backend/pages/1/toggle_visibility' }
    end

    it '#default' do
      expect(instance.data).to eq []
    end

    it 'results without parent ID' do
      pages = [create(:page, visible: 1), create(:page, visible: 1), create(:page, visible: 1)]
      expected_result = pages.inject([]) do |stack, p|
        stack << {
          text: 'Foo',
          type: :file,
          li_attr: nil,
          data: {
            id: p.id,
            url: '/backend/pages/1/edit/nl',
            delete_url: '/backend/pages/1',
            deletable: true,
            draggable: true,
            update_position_url: '/backend/pages/1/tree_drag_and_drop',
            visible: true,
            toggle_visibility_url: '/backend/pages/1/toggle_visibility'
          },
          children: []
        }
      end

      expect(instance.data).to eq expected_result
    end

    it 'results with parent ID' do

    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:data)
  end
end

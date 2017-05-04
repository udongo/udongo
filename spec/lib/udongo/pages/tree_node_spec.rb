require 'rails_helper'

describe Udongo::Pages::TreeNode do
  let(:route_context) { OpenStruct.new }
  let(:page) { create(:page, description: 'Home') }
  let(:instance) { described_class.new(route_context, page) }

  describe '#list_attributes' do
    it 'page visible' do
      page.visible = true
      expect(instance.list_attributes).to be nil
    end

    it 'page invisible' do
      page.visible = false
      expect(instance.list_attributes).to eq({ class: 'jstree-node-invisible', title: 'Deze pagina is niet zichtbaar op de website.' })
    end
  end

  it '#data' do
    allow(route_context).to receive(:backend_page_path) { '/backend/pages/1' }
    allow(route_context).to receive(:edit_translation_backend_page_path) { '/backend/pages/1/edit/nl' }
    allow(route_context).to receive(:tree_drag_and_drop_backend_page_path) { '/backend/pages/1/tree_drag_and_drop' }
    allow(route_context).to receive(:toggle_visibility_backend_page_path) { '/backend/pages/1/toggle_visibility' }

    page.visible = true
    page.deletable = true
    page.draggable = true

    expected_result = {
      text: 'Home',
      type: :file,
      li_attr: nil,
      data: {
        id: page.id,
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

    expect(instance.data).to eq expected_result
  end

  it '#state' do
    expect(instance.state).to eq({ selected: false })
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:data, :list_attributes, :state)
  end
end

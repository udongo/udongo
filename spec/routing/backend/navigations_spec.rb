require 'rails_helper'

describe 'navigation routes' do
  it 'GET /backend/navigations' do
    expect(get: backend_navigations_path).to route_to('backend/navigations#index')
  end

  # TODO no show

  it 'GET /backend/navigations/new' do
    expect(get: '/backend/navigations/new').to route_to('catch_all#resolve', path: 'backend/navigations/new')
  end

  it 'POST /backend/navigations' do
    expect(post: '/backend/navigations').not_to be_routable
  end

  it 'GET /backend/navigations/1/edit' do
    expect(get: '/backend/navigations/1/edit').to route_to('catch_all#resolve', path: 'backend/navigations/1/edit')
  end

  it 'PUT /backend/navigations' do
    expect(put: '/backend/navigations').not_to be_routable
  end

  it 'DELETE /backend/navigations/1' do
    expect(put: '/backend/navigations/1').not_to be_routable
  end

  it 'GET /backend/navigations/1/items' do
    expect(get: backend_navigation_items_path(1)).to route_to('catch_all#resolve', path: 'backend/navigations/1/items')
  end

  it 'GET /backend/navigations/1/items/2' do
    expect(get: '/backend/navigations/1/items/2').to route_to('catch_all#resolve', path: 'backend/navigations/1/items/2')
  end

  it 'GET /backend/navigations/1/items/new' do
    expect(get: new_backend_navigation_item_path(1)).to route_to('backend/navigation/items#new', navigation_id: '1')
  end

  it 'POST /backend/navigations/1/items' do
    expect(post: backend_navigation_items_path(1)).to route_to('backend/navigation/items#create', navigation_id: '1')
  end

  it 'GET /backend/navigations/1/items/2/edit' do
    expect(get: edit_backend_navigation_item_path(1, 2)).to route_to('backend/navigation/items#edit', navigation_id: '1', id: '2')
  end

  it 'PUT /backend/navigations/1/items/2' do
    expect(put: backend_navigation_item_path(1, 2)).to route_to('backend/navigation/items#update', navigation_id: '1', id: '2')
  end

  it 'DELETE /backend/navigations/1/items/2' do
    expect(delete: backend_navigation_item_path(1, 2)).to route_to('backend/navigation/items#destroy', navigation_id: '1', id: '2')
  end

  it 'GET /backend/navigations/1/items/2/edit/nl' do
    expect(get: edit_translation_backend_navigation_item_path(1, 2, 'nl')).to route_to('backend/navigation/items#edit_translation', navigation_id: '1', id: '2', translation_locale: 'nl')
  end

  it 'PATCH /backend/navigations/1/items/2/edit/nl' do
    expect(patch: edit_translation_backend_navigation_item_path(1, 2, 'nl')).to route_to('backend/navigation/items#update_translation', navigation_id: '1', id: '2', translation_locale: 'nl')
  end

  it 'POST /backend/navigations/1/items/2/update_position' do
    expect(post: update_position_backend_navigation_item_path(1, 2)).to route_to('backend/navigation/items#update_position', navigation_id: '1', id: '2')
  end
end

require 'rails_helper'

describe 'page routes' do
  it 'GET /backend/pages' do
    expect(get: '/backend/pages').to route_to('backend/pages#index')
  end

  it 'GET /backend/pages/1' do
    expect(get: '/backend/pages/1').to route_to('catch_all#resolve', path: 'backend/pages/1')
  end

  it 'GET /backend/pages/new' do
    expect(get: new_backend_page_path).to route_to('backend/pages#new')
  end

  it 'POST /backend/pages/create' do
    expect(post: backend_pages_path).to route_to('backend/pages#create')
  end

  it 'GET /backend/pages/1/edit' do
    expect(get: edit_backend_page_path(1)).to route_to('backend/pages#edit', id: '1')
  end

  it 'PUT /backend/pages' do
    expect(put: backend_page_path(1)).to route_to('backend/pages#update', id: '1')
  end

  it 'DELETE /backend/pages/1' do
    expect(delete: backend_page_path(1)).to route_to('backend/pages#destroy', id: '1')
  end

  it 'GET /backend/pages/1/edit/nl' do
    expect(get: edit_translation_backend_page_path(1, 'nl')).to(
      route_to('backend/pages#edit_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'PUT /backend/pages/1/edit/nl' do
    expect(patch: '/backend/pages/1/edit/nl').to(
      route_to('backend/pages#update_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'POST /backend/pages/1/tree_drag_and_drop' do
    expect(post: tree_drag_and_drop_backend_page_path(1)).to route_to('backend/pages#tree_drag_and_drop', id: '1')
  end
end

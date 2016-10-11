require 'rails_helper'

describe 'snippet routes' do
  it 'GET /backend/snippets' do
    expect(get: backend_snippets_path).to route_to('backend/snippets#index')
  end

  it 'GET /backend/snippets/1' do
    expect(get: '/backend/snippets/1').to route_to('catch_all#resolve', path: 'backend/snippets/1')
  end

  it 'GET /backend/snippets/new' do
    expect(get: new_backend_snippet_path).to route_to('backend/snippets#new')
  end

  it 'POST /backend/snippets/create' do
    expect(post: backend_snippets_path).to route_to('backend/snippets#create')
  end

  it 'GET /backend/snippets/1/edit' do
    expect(get: edit_backend_snippet_path(1)).to route_to('backend/snippets#edit', id: '1')
  end

  it 'PUT /backend/snippets' do
    expect(put: backend_snippet_path(1)).to route_to('backend/snippets#update', id: '1')
  end

  it 'DELETE /backend/snippets/1' do
    expect(delete: backend_snippet_path(1)).not_to be_routable
  end

  it 'GET /backend/snippets/1/edit/nl' do
    expect(get: edit_translation_backend_snippet_path(1, 'nl')).to(
      route_to('backend/snippets#edit_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'PUT /backend/snippets/1/edit/nl' do
    expect(patch: edit_translation_backend_snippet_path(1, 'nl')).to(
      route_to('backend/snippets#update_translation', id: '1', translation_locale: 'nl')
    )
  end
end

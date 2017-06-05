require 'rails_helper'

describe 'tag routes' do
  it 'GET /backend/tags' do
    expect(get: backend_tags_path).to route_to('backend/tags#index')
  end

  it 'GET /backend/tags/1' do
    expect(get: backend_tag_path(1)).to route_to('backend/tags#show', id: '1')
  end

  it 'GET /backend/tags/new' do
    expect(get: new_backend_tag_path).to route_to('backend/tags#new')
  end

  it 'POST /backend/tags/create' do
    expect(post: backend_tags_path).to route_to('backend/tags#create')
  end

  it 'GET /backend/tags/1/edit' do
    expect(get: edit_backend_tag_path(1)).to route_to('backend/tags#edit', id: '1')
  end

  it 'PUT /backend/tags' do
    expect(put: backend_tag_path(1)).to route_to('backend/tags#update', id: '1')
  end

  it 'DELETE /backend/tags/1' do
    expect(delete: backend_tag_path(1)).to route_to('backend/tags#destroy', id: '1')
  end
end

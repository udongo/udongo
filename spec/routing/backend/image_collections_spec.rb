require 'rails_helper'

describe 'image collection routes' do
  it 'GET /backend/image_collections' do
    expect(get: backend_image_collections_path).to route_to('backend/image_collections#index')
  end

  it 'GET /backend/image_collections/1' do
    expect(get: '/backend/image_collections/1').to route_to('backend/image_collections#show', id: '1')
  end

  it 'GET /backend/image_collections/new' do
    expect(get: new_backend_image_collection_path).to route_to('backend/image_collections#new')
  end

  it 'POST /backend/image_collections/create' do
    expect(post: backend_image_collections_path).to route_to('backend/image_collections#create')
  end

  it 'GET /backend/image_collections/1/edit' do
    expect(get: edit_backend_image_collection_path(1)).to route_to('backend/image_collections#edit', id: '1')
  end

  it 'PUT /backend/image_collections' do
    expect(put: backend_image_collection_path(1)).to route_to('backend/image_collections#update', id: '1')
  end

  it 'DELETE /backend/image_collections/1' do
    expect(delete: backend_image_collection_path(1)).to route_to('backend/image_collections#destroy', id: '1')
  end

  it 'GET /backend/image_collections/1/images' do
    expect(get: backend_image_collection_images_path(1)).to route_to('backend/image_collections/images#index', image_collection_id: '1')
  end

  it 'POST /backend/image_collections/1/images/2/update_position' do
    expect(post: update_position_backend_image_collection_image_path(1, 2)).to route_to('backend/image_collections/images#update_position', image_collection_id: '1', id: '2')
  end
end


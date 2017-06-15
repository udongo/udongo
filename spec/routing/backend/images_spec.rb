require 'rails_helper'

describe 'image routes' do
  it 'GET /backend/images' do
    expect(get: backend_images_path).to route_to('backend/images#index')
  end

  it 'GET /backend/images/1' do
    expect(get: '/backend/images/1').to route_to('catch_all#resolve', path: 'backend/images/1')
  end

  it 'GET /backend/images/new' do
    expect(get: new_backend_image_path).to route_to('backend/images#new')
  end

  it 'POST /backend/images/create' do
    expect(post: backend_images_path).to route_to('backend/images#create')
  end

  it 'GET /backend/images/1/edit' do
    expect(get: '/backend/images/1/edit').to route_to('catch_all#resolve', path: 'backend/images/1/edit')
  end

  it 'PUT /backend/images/1' do
    expect(put: '/backend/images/1').not_to be_routable
  end

  it 'DELETE /backend/images/1' do
    expect(delete: '/backend/images/1/').not_to be_routable
  end

  it 'GET /backend/images/link' do
    expect(get: link_backend_images_path).to route_to('backend/images#link')
  end

  it 'GET /backend/images/unlink' do
    expect(get: unlink_backend_images_path).to route_to('backend/images#unlink')
  end
end

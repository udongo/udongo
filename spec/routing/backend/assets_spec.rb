require 'rails_helper'

describe 'asset routes' do
  it 'GET /backend/assets' do
    expect(get: backend_assets_path).to route_to('backend/assets#index')
  end

  it 'GET /backend/assets/1' do
    expect(get: '/backend/assets/1').to route_to('backend/assets#show', id: '1')
  end

  it 'GET /backend/assets/new' do
    expect(get: new_backend_asset_path).to route_to('backend/assets#new')
  end

  it 'POST /backend/assets' do
    expect(post: backend_assets_path).to route_to('backend/assets#create')
  end

  it 'GET /backend/assets/1/edit' do
    expect(get: edit_backend_asset_path(1)).to route_to('backend/assets#edit', id: '1')
  end

  it 'PUT /backend/assets' do
    expect(put: backend_asset_path(1)).to route_to('backend/assets#update', id: '1')
  end

  it 'DELETE /backend/assets/1' do
    expect(delete: backend_asset_path(1)).to route_to('backend/assets#destroy', id: '1')
  end
end

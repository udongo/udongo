require 'rails_helper'

describe 'admin routes' do
  it 'GET /backend/admins' do
    expect(get: backend_admins_path).to route_to('backend/admins#index')
  end

  it 'GET /backend/admins/1' do
    expect(get: backend_admin_path(1)).to route_to('backend/admins#show', id: '1')
  end

  it 'GET /backend/admins/new' do
    expect(get: new_backend_admin_path).to route_to('backend/admins#new')
  end

  it 'POST /backend/admins/create' do
    expect(post: backend_admins_path).to route_to('backend/admins#create')
  end

  it 'GET /backend/admins/1/edit' do
    expect(get: edit_backend_admin_path(1)).to route_to('backend/admins#edit', id: '1')
  end

  it 'PUT /backend/admins' do
    expect(put: backend_admin_path(1)).to route_to('backend/admins#update', id: '1')
  end

  it 'DELETE /backend/admins/1' do
    expect(delete: backend_admin_path(1)).to route_to('backend/admins#destroy', id: '1')
  end
end

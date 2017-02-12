require 'rails_helper'

describe 'user routes' do
  it 'GET /backend/users' do
    expect(get: backend_users_path).to route_to('backend/users#index')
  end

  it 'GET /backend/users/1' do
    expect(get: '/backend/users/1').to route_to('backend/users#show', id: '1')
  end

  it 'GET /backend/users/new' do
    expect(get: new_backend_user_path).to route_to('backend/users#new')
  end

  it 'POST /backend/users/create' do
    expect(post: backend_users_path).to route_to('backend/users#create')
  end

  it 'GET /backend/users/1/edit' do
    expect(get: edit_backend_user_path(1)).to route_to('backend/users#edit', id: '1')
  end

  it 'PUT /backend/users' do
    expect(put: backend_user_path(1)).to route_to('backend/users#update', id: '1')
  end

  it 'DELETE /backend/users/1' do
    expect(delete: backend_user_path(1)).to route_to('backend/users#destroy', id: '1')
  end
end

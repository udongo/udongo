require 'rails_helper'

describe 'admin routes' do
  it 'GET /backend/admins' do
    expect(get: backend_admins_path).to route_to(
                                          controller: 'backend/admins',
                                          action: 'index'
                                        )
  end

  it 'GET /backend/admins/1' do
    expect(get: backend_admin_path(1)).to route_to(
                                            controller: 'backend/admins',
                                            action: 'show',
                                            id: '1'
                                          )
  end

  it 'GET /backend/admins/new' do
    expect(get: new_backend_admin_path).to route_to(
                                             controller: 'backend/admins',
                                             action: 'new'
                                           )
  end

  it 'POST /backend/admins/create' do
    expect(post: backend_admins_path).to route_to(
                                             controller: 'backend/admins',
                                             action: 'create'
                                           )
  end

  it 'GET /backend/admins/1/edit' do
    expect(get: edit_backend_admin_path(1)).to route_to(
                                                 controller: 'backend/admins',
                                                 action: 'edit',
                                                 id: '1'
                                               )
  end

  it 'PUT /backend/admins' do
    expect(put: backend_admin_path(1)).to route_to(
                                            controller: 'backend/admins',
                                            action: 'update',
                                            id: '1'
                                          )
  end

  it 'DELETE /backend/admins/1' do
    expect(delete: backend_admin_path(1)).to route_to(
                                                 controller: 'backend/admins',
                                                 action: 'destroy',
                                                 id: '1'
                                               )
  end
end

require 'rails_helper'

describe 'session routes' do
  it 'GET /backend/sessions' do
    expect(get: backend_sessions_path).to route_to('catch_all#resolve', path: 'backend/sessions')
  end

  it 'GET /backend/sessions/1' do
    expect(get: '/backend/sessions/1').to route_to('catch_all#resolve', path: 'backend/sessions/1')
  end

  it 'GET /backend/sessions/new' do
    expect(get: new_backend_session_path).to route_to('backend/sessions#new')
  end

  it 'POST /backend/sessions/create' do
    expect(post: backend_sessions_path).to route_to('backend/sessions#create')
  end

  it 'GET /backend/sessions/1/edit' do
    expect(get: '/backend/sessions/1/edit').to route_to('catch_all#resolve', path: 'backend/sessions/1/edit')
  end

  it 'PUT /backend/sessions' do
    expect(put: backend_sessions_path).not_to be_routable
  end

  it 'DELETE /backend/sessions/1' do
    expect(delete: backend_session_path(1)).to route_to('backend/sessions#destroy', id: '1')
  end
end

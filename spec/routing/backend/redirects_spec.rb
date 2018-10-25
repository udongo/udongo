require 'rails_helper'

describe 'redirect routes' do
  it 'GET /backend/redirects' do
    expect(get: backend_redirects_path).to route_to('backend/redirects#index')
  end

  it 'GET /backend/redirects/1' do
    expect(get: '/backend/redirects/1').to route_to('backend/redirects#show', id: '1')
  end

  it 'GET /backend/redirects/new' do
    expect(get: new_backend_redirect_path).to route_to('backend/redirects#new')
  end

  it 'POST /backend/redirects/create' do
    expect(post: backend_redirects_path).to route_to('backend/redirects#create')
  end

  it 'POST /backend/redirects/test/resolve' do
    expect(post: resolve_backend_test_redirect_path(1)).to route_to('backend/redirects/test#resolve', id: '1')
  end

  it 'GET /backend/redirects/1/edit' do
    expect(get: edit_backend_redirect_path(1)).to route_to('backend/redirects#edit', id: '1')
  end

  it 'PUT /backend/redirects' do
    expect(put: backend_redirect_path(1)).to route_to('backend/redirects#update', id: '1')
  end

  it 'DELETE /backend/redirects/1' do
    expect(delete: backend_redirect_path(1)).to route_to('backend/redirects#destroy', id: '1')
  end
end

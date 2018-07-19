require 'rails_helper'

describe 'search routes' do
  it 'GET /backend/searches' do
    expect(get: backend_searches_path).to route_to('backend/searches#index')
  end

  it 'DELETE /backend/searches' do
    expect(delete: backend_searches_path).to route_to('backend/searches#destroy_all')
  end
end

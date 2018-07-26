require 'rails_helper'

describe 'search routes' do
  it 'GET /backend/search_terms' do
    expect(get: backend_search_terms_path).to route_to('backend/search_terms#index')
  end

  it 'DELETE /backend/search_terms' do
    expect(delete: backend_search_terms_path).to route_to('backend/search_terms#destroy_all')
  end
end

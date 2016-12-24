require 'rails_helper'

describe 'general routes' do
  it 'GET /backend' do
    expect(get: backend_path).to route_to('backend/dashboard#show')
  end
end

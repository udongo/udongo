require 'rails_helper'

describe 'tagbox routes' do
  it 'GET /backend/tagbox' do
    expect(get: backend_tagbox_path).to route_to('backend/tagbox#index')
  end

  it 'POST /backend/tagbox' do
    expect(post: backend_tagbox_path).to route_to('backend/tagbox#create')
  end

  it 'DELETE /backend/tagbox' do
    expect(delete: backend_tagbox_path).to route_to('backend/tagbox#destroy')
  end
end

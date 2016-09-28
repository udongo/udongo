require 'rails_helper'

describe 'general routes' do
  it 'GET /backend' do
    expect(get: backend_path).to route_to(
                                   controller: 'backend/dashboard',
                                   action: 'show'
                                 )
  end

  it 'POST /backend/restart_webserver' do
    expect(post: backend_restart_webserver_path).to route_to(
                                                      controller: 'backend/webserver',
                                                      action: 'restart'
                                                    )
  end
end

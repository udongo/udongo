require 'rails_helper'

describe 'redirects via go' do
  it 'GET /go/foo' do
    expect(get: '/go/foo').to route_to(
                                controller: 'redirects',
                                action: 'go',
                                slug: 'foo'
                              )
  end

  it 'GET /go/12345678' do
    expect(get: '/go/12345678').to route_to(
                                     controller: 'redirects',
                                     action: 'go',
                                     slug: '12345678'
                                   )
  end
end

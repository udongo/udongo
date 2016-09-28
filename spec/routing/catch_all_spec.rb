require 'rails_helper'

describe 'catch all' do
  it 'GET /foo' do
    expect(get: '/foo').to route_to(
                             controller: 'catch_all',
                             action: 'resolve',
                             path: 'foo'
                           )
  end

  it 'GET /foo/bar' do
    expect(get: '/foo/bar').to route_to(
                                 controller: 'catch_all',
                                 action: 'resolve',
                                 path: 'foo/bar'
                               )
  end

  it 'GET /foo/bar/baz' do
    expect(get: '/foo/bar/baz').to route_to(
                                     controller: 'catch_all',
                                     action: 'resolve',
                                     path: 'foo/bar/baz'
                                   )
  end

  it 'GET /foo/bar.js' do
    expect(get: '/foo/bar.js').to route_to(
                                    controller: 'catch_all',
                                    action: 'resolve',
                                    path: 'foo/bar',
                                    format: 'js'
                                  )
  end
end

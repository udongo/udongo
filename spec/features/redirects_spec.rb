require 'rails_helper'

describe 'redirects' do
  it 'no such redirect /go/foo' do
    visit '/go/foo'
    expect(page.body).to eq 'No such redirect or disabled.'
    expect(page.status_code).to eq 404
  end

  it 'redirect exists /go/foo' do
    create(:redirect, source_uri: '/go/foo', destination_uri: '/bar', status_code: 301)

    visit '/go/foo'
    expect(page).to have_current_path('/bar')
    expect(page.status_code).to eq 404
  end
end

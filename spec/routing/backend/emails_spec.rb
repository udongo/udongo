require 'rails_helper'

describe 'email routes' do
  it 'GET /backend/emails' do
    expect(get: backend_emails_path).to route_to('backend/emails#index')
  end

  it 'GET /backend/emails/1' do
    expect(get: '/backend/emails/1').to route_to('backend/emails#show', id: '1')
  end

  it 'GET /backend/emails/new' do
    expect(get: 'backend/emails/new').to route_to('backend/emails#show', id: 'new')
  end

  it 'POST /backend/emails' do
    expect(post: '/backend/emails').not_to be_routable
  end

  it 'GET /backend/emails/1/edit' do
    expect(get: '/backend/emails/1/edit').to route_to('catch_all#resolve', path: 'backend/emails/1/edit')
  end

  it 'PUT /backend/emails' do
    expect(put: backend_email_path(1)).not_to be_routable
  end

  it 'DELETE /backend/emails/1' do
    expect(delete: backend_email_path(1)).not_to be_routable
  end

  it 'GET /backend/emails/1/html_content' do
    expect(get: html_content_backend_email_path(1)).to route_to('backend/emails#html_content', id: '1')
  end
end

require 'rails_helper'

describe 'email_template routes' do
  it 'GET /backend/email_templates' do
    expect(get: backend_email_templates_path).to route_to('backend/email_templates#index')
  end

  it 'GET /backend/email_templates/1' do
    expect(get: '/backend/email_templates/1').to route_to('catch_all#resolve', path: 'backend/email_templates/1')
  end

  it 'GET /backend/email_templates/new' do
    expect(get: new_backend_email_template_path).to route_to('backend/email_templates#new')
  end

  it 'POST /backend/email_templates/create' do
    expect(post: backend_email_templates_path).to route_to('backend/email_templates#create')
  end

  it 'GET /backend/email_templates/1/edit' do
    expect(get: edit_backend_email_template_path(1)).to route_to('backend/email_templates#edit', id: '1')
  end

  it 'PUT /backend/email_templates' do
    expect(put: backend_email_template_path(1)).to route_to('backend/email_templates#update', id: '1')
  end

  it 'DELETE /backend/email_templates/1' do
    expect(delete: backend_email_template_path(1)).not_to be_routable
  end

  it 'GET /backend/email_templates/1/edit/nl' do
    expect(get: edit_translation_backend_email_template_path(1, 'nl')).to(
      route_to('backend/email_templates#edit_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'PATCH /backend/email_templates/1/edit/nl' do
    expect(patch: edit_translation_backend_email_template_path('1', 'nl')).to(
      route_to('backend/email_templates#update_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'POST /backend/email_templates/1/update_position' do
    expect(post: update_position_backend_email_template_path(1)).to route_to('backend/email_templates#update_position', id: '1')
  end
end

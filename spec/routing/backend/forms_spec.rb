require 'rails_helper'

describe 'form routes' do
  it 'GET /backend/forms' do
    expect(get: backend_forms_path).to route_to('backend/forms#index')
  end

  it 'GET /backend/forms/1' do
    expect(get: backend_form_path(1)).to route_to('backend/forms#show', id: '1')
  end

  it 'GET /backend/forms/new' do
    expect(get: new_backend_form_path).to route_to('backend/forms#new')
  end

  it 'POST /backend/forms' do
    expect(post: backend_forms_path).to route_to('backend/forms#create')
  end

  it 'GET /backend/forms/1/edit' do
    expect(get: edit_backend_form_path(1)).to route_to('backend/forms#edit', id: '1')
  end

  it 'PUT /backend/forms' do
    expect(put: backend_form_path(1)).to route_to('backend/forms#update', id: '1')
  end

  it 'DELETE /backend/forms/1' do
    expect(delete: backend_form_path(1)).to route_to('backend/forms#destroy', id: '1')
  end

  it 'GET /backend/forms/1/edit/nl' do
    expect(get: edit_translation_backend_form_path(1, 'nl')).to(
      route_to('backend/forms#edit_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'PUT /backend/forms/1/edit/nl' do
    expect(patch: edit_translation_backend_form_path(1, 'nl')).to(
      route_to('backend/forms#update_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'GET /backend/forms/1/submissions' do
    expect(get: backend_form_submissions_path(1)).to route_to('backend/forms/submissions#index', form_id: '1')
  end

  it 'GET /backend/forms/1/submissions/2' do
    expect(get: backend_form_submission_path(1, 2)).to route_to('backend/forms/submissions#show', form_id: '1', id: '2')
  end

  it 'GET /backend/forms/1/submissions/2/edit' do
    expect(get: edit_backend_form_submission_path(1, 2)).to route_to('backend/forms/submissions#edit', form_id: '1', id: '2')
  end

  it 'GET /backend/forms/1/submissions/2/edit' do
    expect(get: edit_backend_form_submission_path(1, 2)).to route_to('backend/forms/submissions#edit', form_id: '1', id: '2')
  end

  it 'PUT /backend/forms/1/submissions' do
    expect(put: backend_form_submission_path(1, 2)).to route_to('backend/forms/submissions#update', form_id: '1', id: '2')
  end

  it 'DELETE /backend/forms/1/submissions/2' do
    expect(delete: backend_form_submission_path(1, 2)).to route_to('backend/forms/submissions#destroy', form_id: '1', id: '2')
  end

  it 'GET /backend/forms/1/fields' do
    expect(get: backend_form_fields_path(1)).to route_to('backend/forms/fields#index', form_id: '1')
  end

  it 'GET /backend/forms/1/fields/2/edit' do
    expect(get: edit_backend_form_field_path(1, 2)).to route_to('backend/forms/fields#edit', form_id: '1', id: '2')
  end

  it 'GET /backend/forms/1/fields/2/edit' do
    expect(get: edit_backend_form_field_path(1, 2)).to route_to('backend/forms/fields#edit', form_id: '1', id: '2')
  end

  it 'PUT /backend/forms/1/fields' do
    expect(put: backend_form_field_path(1, 2)).to route_to('backend/forms/fields#update', form_id: '1', id: '2')
  end

  it 'DELETE /backend/forms/1/fields/2' do
    expect(delete: backend_form_field_path(1, 2)).to route_to('backend/forms/fields#destroy', form_id: '1', id: '2')
  end

  it 'GET /backend/forms/1/fields/2/edit/nl' do
    expect(get: edit_translation_backend_form_field_path(1, 2, 'nl')).to(
      route_to('backend/forms/fields#edit_translation', form_id: '1', id: '2', translation_locale: 'nl')
    )
  end

  it 'PUT /backend/forms/1/fields/2/edit/nl' do
    expect(patch: edit_translation_backend_form_field_path(1, 2, 'nl')).to(
      route_to('backend/forms/fields#update_translation', form_id: '1', id: '2', translation_locale: 'nl')
    )
  end

  it 'POST /backend/forms/1/fields/2/edit/nl' do
    expect(post: update_position_backend_form_field_path(1, 2)).to(
      route_to('backend/forms/fields#update_position', form_id: '1', id: '2')
    )
  end
end

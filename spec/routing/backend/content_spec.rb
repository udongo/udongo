require 'rails_helper'

describe 'content routes' do
  it 'GET /backend/content/rows' do
    expect(get: backend_content_rows_path).to route_to('backend/content/rows#index')
  end

  it 'GET /backend/content/rows/1' do
    expect(get: '/backend/content/rows/1').to route_to('catch_all#resolve', path: 'backend/content/rows/1')
  end

  it 'GET /backend/content/rows/new' do
    expect(get: new_backend_content_row_path).to route_to('backend/content/rows#new')
  end

  it 'POST /backend/content/rows' do
    expect(post: backend_content_rows_path).not_to be_routable
  end

  it 'GET /backend/content/rows/1/edit' do
    expect(get: '/backend/content/rows/1/edit').to route_to('catch_all#resolve', path: 'backend/content/rows/1/edit')
  end

  it 'PUT /backend/content/rows/1' do
    expect(put: '/backend/content/rows/1').not_to be_routable
  end

  it 'GET /backend/content/rows/1/horizontal_alignment' do
    expect(get: horizontal_alignment_backend_content_row_path(1)).to route_to('backend/content/rows#horizontal_alignment', id: '1')
  end

  it 'GET /backend/content/rows/1/vertical_alignment' do
    expect(get: vertical_alignment_backend_content_row_path(1)).to route_to('backend/content/rows#vertical_alignment', id: '1')
  end

  it 'GET /backend/content/rows/1/toggle_full_width' do
    expect(get: toggle_full_width_backend_content_row_path(1)).to route_to('backend/content/rows#toggle_full_width', id: '1')
  end

  it 'DELETE /backend/content/rows/1' do
    expect(delete: '/backend/content/rows/1').to route_to('backend/content/rows#destroy', id: '1')
  end

  it 'POST /backend/content/rows/1/update_position' do
    expect(post: update_position_backend_content_row_path(1)).to route_to('backend/content/rows#update_position', id: '1')
  end

  it 'GET /backend/content/rows/1/columns' do
    expect(get: backend_content_row_columns_path(1)).to route_to('catch_all#resolve', path: 'backend/content/rows/1/columns')
  end

  it 'GET /backend/content/rows/1/columns/2' do
    expect(get: '/backend/content/rows/1/columns/2').to route_to('catch_all#resolve', path: 'backend/content/rows/1/columns/2')
  end

  it 'GET /backend/content/rows/1/columns/new' do
    expect(get: new_backend_content_row_column_path(1)).to route_to('backend/content/rows/columns#new', row_id: '1')
  end

  it 'POST /backend/content/rows/1/columns' do
    expect(post: backend_content_row_columns_path(1)).to route_to('backend/content/rows/columns#create', row_id: '1')
  end

  it 'GET /backend/content/rows/1/columns/2/edit' do
    expect(get: edit_backend_content_row_column_path(1, 2)).to route_to('backend/content/rows/columns#edit', row_id: '1', id: '2')
  end

  it 'PUT /backend/content/rows/1/columns/2' do
    expect(put: backend_content_row_column_path(1, 2)).to route_to('backend/content/rows/columns#update', row_id: '1', id: '2')
  end

  it 'DELETE /backend/content/rows/1/columns/2' do
    expect(delete: backend_content_row_column_path(1, 2)).to route_to('backend/content/rows/columns#destroy', row_id: '1', id: '2')
  end

  it 'POST /backend/content/rows/1/columns/2/update_position' do
    expect(post: update_position_backend_content_row_column_path(1, 2)).to route_to('backend/content/rows/columns#update_position', row_id: '1', id: '2')
  end

  it 'GET edit for flexible content types' do
    Udongo.config.flexible_content.types.each do |content_type|
      plural = content_type.to_s.pluralize
      expect(get: "/backend/content/#{plural}/1/edit").to route_to("backend/content/rows/#{plural}#edit", id: '1')
    end
  end

  it 'PUT update for flexible content types' do
    Udongo.config.flexible_content.types.each do |content_type|
      plural = content_type.to_s.pluralize
      expect(put: "/backend/content/#{plural}/1").to route_to("backend/content/rows/#{plural}#update", id: '1')
    end
  end

  it 'GET /backend/content/pictures/1/link_or_upload' do
    expect(get: link_or_upload_backend_content_picture_path(1)).to route_to('backend/content/rows/pictures#link_or_upload', id: '1')
  end

  it 'GET /backend/content/pictures/1/link' do
    expect(get: link_backend_content_picture_path(1)).to route_to('backend/content/rows/pictures#link', id: '1')
  end

  it 'POST /backend/content/pictures/1/upload' do
    expect(post: upload_backend_content_picture_path(1)).to route_to('backend/content/rows/pictures#upload', id: '1')
  end
end

require 'rails_helper'

describe 'article routes' do
  it 'GET /backend/articles' do
    expect(get: backend_articles_path).to route_to('backend/articles#index')
  end

  it 'GET /backend/articles/1' do
    expect(get: '/backend/articles/1').to route_to('catch_all#resolve', path: 'backend/articles/1')
  end

  it 'GET /backend/articles/new' do
    expect(get: new_backend_article_path).to route_to('backend/articles#new')
  end

  it 'POST /backend/articles/create' do
    expect(post: backend_articles_path).to route_to('backend/articles#create')
  end

  it 'GET /backend/articles/1/edit' do
    expect(get: edit_backend_article_path(1)).to route_to('backend/articles#edit', id: '1')
  end

  it 'PUT /backend/articles' do
    expect(put: backend_article_path(1)).to route_to('backend/articles#update', id: '1')
  end

  it 'DELETE /backend/articles/1' do
    expect(delete: backend_article_path(1)).to route_to('backend/articles#destroy', id: '1')
  end

  it 'GET /backend/articles/1/edit/nl' do
    expect(get: edit_translation_backend_article_path(1, 'nl')).to(
      route_to('backend/articles#edit_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'PUT /backend/articles/1/edit/nl' do
    expect(patch: edit_translation_backend_article_path('1', 'nl')).to(
      route_to('backend/articles#update_translation', id: '1', translation_locale: 'nl')
    )
  end

  it 'GET /backend/articles/1/images' do
    expect(get: backend_article_images_path(1)).to route_to('backend/articles/images#index', article_id: '1')
  end

  it 'POST /backend/articles/1/images/2/update_position' do
    expect(post: update_position_backend_article_image_path(1, 2)).to route_to('backend/articles/images#update_position', article_id: '1', id: '2')
  end
end

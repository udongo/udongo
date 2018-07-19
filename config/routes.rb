Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  namespace :backend do
    concern :translatable do
      member do
        patch 'edit/:translation_locale', action: :update_translation
        get 'edit/:translation_locale', action: :edit_translation, as: :edit_translation
      end
    end

    concern :positionable do
      member { post :update_position }
    end

    get '/' => 'dashboard#show'
    get 'search' => 'search#query'
    get 'seo/slugify' => 'seo#slugify'

    resources :sessions, only: [:new, :create, :destroy]
    resources :admins
    resources :searches, only: [:index] do
      collection { delete '/', action: 'destroy_all' }
    end
    resources :users
    resources :redirects, except: :show
    resources :search_synonyms, except: :show
    resources :tags do
      concerns :translatable
    end

    resources :pages, except: [:show] do
      concerns :translatable

      member do
        post :tree_drag_and_drop, :toggle_visibility
      end

      resources :images, only: [:index], controller: 'pages/images' do
        concerns :positionable
      end
    end

    resources :forms do
      concerns :translatable
      resources :submissions, controller: 'forms/submissions', except: %w(new create)

      resources :fields, controller: 'forms/fields', except: %w(show) do
        concerns :translatable, :positionable
      end
    end

    resources :image_collections do
      resources :images, only: [:index], controller: 'image_collections/images' do
        concerns :positionable
      end
    end

    resources :articles, except: [:show] do
      concerns :translatable

      resources :images, only: [:index], controller: 'articles/images' do
        concerns :positionable
      end
    end

    resources :navigations, only: [:index] do
      scope module: 'navigation' do
        resources :items, except: [:index, :show] do
          concerns :translatable
          concerns :positionable
        end
      end
    end

    resources :snippets, except: [:show, :destroy] do
      concerns :translatable
    end

    resources :email_templates, except: [:show, :destroy] do
      concerns :translatable
      concerns :positionable
    end

    scope :tagbox, controller: 'tagbox', as: 'tagbox' do
      get '/', action: 'index'
      post '/', action: 'create'
      delete '/', action: 'destroy'
    end

    resources :emails, only: [:index, :show] do
      member do
        get 'html_content'
      end
    end

    namespace :content do
      get 'duplicate/:model/:id/:source_locale/:destination_locale' => 'duplicate#execute', as: :duplicate

      resources :rows, only: [:index, :new, :edit, :update, :destroy] do
        member do
          get :horizontal_alignment, :vertical_alignment, :toggle_full_width
        end

        concerns :positionable

        scope module: 'rows' do
          resources :columns, except: [:index, :show] do
            concerns :positionable
          end
        end
      end

      scope module: 'rows' do
        Udongo.config.flexible_content.types.each do |content_type|
          next if content_type == 'picture'
          resources content_type.to_s.pluralize.to_sym, only: [:edit, :update]
        end

        resources :pictures, only: [:edit, :update] do
          member do
            get :link_or_upload, :link
            post :upload
          end
        end
      end
    end

    resources :images, only: [:index, :new, :create] do
      collection { get 'link', 'unlink' }
    end

    resources :assets
  end

  get 'go/:slug' => 'redirects#go'
  get '*path' => 'catch_all#resolve'
end

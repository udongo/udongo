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

    resources :sessions, only: [:new, :create, :destroy]
    resources :admins
    resources :users
    resources :redirects, except: :show
    resources :search_synonyms, except: :show

    resources :pages, except: [:show] do
      concerns :translatable

      member do
        post :tree_drag_and_drop, :toggle_visibility
      end
    end

    resources :articles, except: [:show] do
      concerns :translatable

      # TODO test me (and turn into concern with param!) eg concerns :imageable, parent: :articles
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
      resources :rows, only: [:index, :new, :destroy] do
        concerns :positionable

        scope module: 'rows' do
          resources :columns, except: [:index, :show] do
            concerns :positionable
          end
        end
      end

      scope module: 'rows' do
        Udongo.config.flexible_content.types.each do |content_type|
          resources content_type.to_s.pluralize.to_sym, only: [:edit, :update]
        end
      end
    end

    # TODO add routing specs
    resources :images, only: [:index] do
      collection do
        get 'link', 'unlink'
      end
    end
    resources :assets
  end

  get 'go/:slug' => 'redirects#go'
  get '*path' => 'catch_all#resolve'
end

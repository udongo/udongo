Rails.application.routes.draw do
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
    post 'seo/slugify' => 'seo#slugify'

    resources :sessions, only: [:new, :create, :destroy]
    resources :admins, except: [:show]

    resources :pages, except: [:show] do
      concerns :translatable
      member { post :tree_drag_and_drop }
    end

    resources :tags, only: [:index, :create] do
      collection { delete '/', action: :destroy }
    end

    namespace :content do
      resources :rows, only: [:index, :new, :destroy] do
        concerns :positionable

        scope module: 'rows' do
          resources :columns
        end
      end

      scope module: 'rows' do
        resources :texts, only: [:edit, :update]
        resources :images, only: [:edit, :update]
      end
    end
  end
end

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

    scope :navigations, as: :navigation do
      resources :items, except: [:edit, :update, :show], controller: 'navigations/items' do
        concerns :positionable
      end
    end

    resources :tags, only: [:index, :create] do
      collection { delete '/', action: :destroy }
    end
  end
end

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


    # TODO check this out
    # Ik wil propere urls dus liefst.
    # /backend/content/rows/new?rowable_type=Page&rowable_id=1&translation=nl

    # > Door de '1' in de URL weten we reeds aan welk object dit hangt. Het rij
    #   object bevat ook de locale.
    # /backend/content/rows/1/columns/new

    # Alles verhuist dus onder de namespace content

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

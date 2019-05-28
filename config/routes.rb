Rails.application.routes.draw do
  root to: 'dashboards#show'

  resources :reports, :bulksheets do
    post :import, on: :member
    post :analyze, on: :member
  end

  resources :search_terms, only: [:index, :show] do
    scope module: :search_terms do
      resources :stats, only: [] do
        collection do
          get :impressions, :clicks
        end
      end
    end
  end

  resources :ad_groups
  resources :campaigns
  resources :keywords, only: [:index, :show]
  resources :skus do
    scope module: :skus do
      resources :search_terms, only: :index
    end
  end
  resources :stats, only: [] do
    collection do
      get :impressions, :clicks, :spend, :sales
    end
  end

  resources :suggestions, only: :index
end

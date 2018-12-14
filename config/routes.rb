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
  resources :skus
  resources :stats, only: [] do
    collection do
      get :impressions, :clicks, :spend, :sales
    end
  end
end

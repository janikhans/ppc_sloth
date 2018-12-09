Rails.application.routes.draw do
  root to: 'dashboards#show'

  resources :reports, :bulksheets do
    post :import, on: :member
    post :analyze, on: :member
  end

  resources :search_terms, only: [:index, :show]
  resources :ad_groups
  resources :campaigns
  resources :keywords, only: [:index, :show]
  resources :skus
end

Rails.application.routes.draw do
  root to: 'dashboards#show'

  resources :search_term_reports do
    post :import, on: :member
  end
  resources :ad_groups
  resources :campaigns
end

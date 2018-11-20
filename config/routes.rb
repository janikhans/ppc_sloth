Rails.application.routes.draw do
  root to: 'dashboards#show'

  resources :search_term_reports
  resources :ad_groups
  resources :campaigns
end

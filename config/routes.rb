Rails.application.routes.draw do
  root to: 'dashboards#show'
  
  resources :ad_groups
  resources :campaigns
end

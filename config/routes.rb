Rails.application.routes.draw do
  resources :comments, only: %i[create]
  resources :posts
  resources :users
  resources :sessions, only: %i[create destroy]

  get '/upload', to: 'amazon_s3_uploads#set_s3_direct_post'
  get '/toggle', to: 'users#toggle'
  match '*path', to: 'sessions#not_found', via: %i[get post put delete]
end

Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users
  resources :sessions

  get '/upload', to: 'amazon_s3_uploads#set_s3_direct_post'
  get '/toggle/:id', to: 'users#toggle'
  delete '/data', to: 'users#data'
  match '*path', to: 'sessions#not_found', via: %i[get post put delete]
end

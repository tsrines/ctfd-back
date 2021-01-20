Rails.application.routes.draw do
  resources :comments, only: %i[create, update]
  resources :posts
  resources :users
  resources :sessions, only: %i[create destroy]

  get '/upload', to: 'amazon_s3_uploads#set_s3_direct_post'
  put '/upload', to: 'amazon_s3_uploads#attach_image_url'
  match '*path', to: 'sessions#not_found', via: %i[get post put delete]
end

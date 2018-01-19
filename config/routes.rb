Rails.application.routes.draw do
  resources :libraries
  resources :categories  
  resources :members
  resources :books
  resources :issue_histories
end

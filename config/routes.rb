Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[index show] do
    post :apply_filter, on: :collection
  end

  root 'products#index'
end

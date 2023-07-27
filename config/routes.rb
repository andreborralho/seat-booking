Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "seats#index"

  resources :seats, only: [:update] do
    post 'update_multiple', on: :collection
  end
end

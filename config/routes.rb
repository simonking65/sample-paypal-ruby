PizzaShop::Application.routes.draw do
  get  "home/index"

  resources :orders do
    get :execute
    get :cancel
  end

  devise_for :users

  root :to => "home#index"
end

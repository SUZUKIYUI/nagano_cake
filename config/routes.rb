Rails.application.routes.draw do

# ------------------------会員側のルート---------------------------

  devise_for :customers

  root to: 'public/homes#top'
  get 'about' => "public/homes#about"

  get 'items' => "public/items#index"
  get 'items/:id' => "public/items#show"

  get 'current_customer' => "public/customers#show"
  get 'current_customer/edit' => "public/customers#edit"
  patch 'current_customer' => "public/customers#update"
  get 'current_customer/leave' => "public/customers#leave"
  patch 'current_customer/withdraw' => "public/customers#withdraw"

  get 'cart_items' => "public/cart_items#index"
  patch 'cart_items/:id' => "public/cart_items#update"
  delete 'cart_items/:id' => "public/cart_items#destroy"
  delete 'cart_items' => "public/cart_items#empty"
  post 'cart_items' => "public/cart_items#create"

  get 'orders/new' => "public/orders#new"
  post 'orders/check' => "public/orders#check"
  get 'orders/thanks' => "public/orders#thanks"
  post 'orders' => "public/orders#create"
  get 'orders' => "public/orders#index"
  get 'orders/:id' => "public/orders#show"

  get 'addresses' => "public/addresses#index"
  get 'addresses/:id/edit' => "public/addresses#edit"
  post 'addresses' => "public/addresses#create"
  patch 'addresses/:id' => "public/addresses#update"
  delete 'addresses/:id' => "public/addresses#destroy"


  # ------------------------お店側のルート--------------------------



  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

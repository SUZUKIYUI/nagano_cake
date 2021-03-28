Rails.application.routes.draw do

# ------------------------会員側のルート---------------------------

  devise_for :customers, skip: :all
  devise_scope :customer do
    get "customers/sign_up" => "public/customers/registrations#new", as: :new_customer_registration
    post "customers" =>"public/customers/registrations#create", as: :customer_registration
    get "customers/sign_in" => "public/customers/sessions#new", as: :new_customer_session
    post "customers/sign_in" => "public/customers/sessions#create", as: :customer_session
    delete "customers/sign_out" => "public/customers/sessions#destroy", as: :destroy_customer_session
    get 'customers/password/new' => 'public/customers/passwords#new', as: :new_customer_password
    get "customers/password/edit" => "public/customers/passwords#edit", as: :edit_customer_password
    patch "customers/password" => "public/customers/passwords#update", as: :customer_password
    # put "customers/password" => "public/customers/passwords#update", as: :customer_password
    # post "customers/password" => "public/customers/passwords#create", as: :customer_password
    get "customers/cancel" => "public/customers/registrations#cancel", as: :cancel_customer_registration
    get "customers/edit" => "public/customers/registrations#edit", as: :edit_customer_registration
    # patch "customers" => "public/customers/registrations#update", as: :customer_registration
    # put "customers" => "public/customers/registrations#update", as: :customer_registration
    # delete "customers" => "public/customers/registrations#destroy", as: :customer_registration
  end

  root to: 'public/homes#top'
  get 'about' => "public/homes#about"

  get 'items' => "public/items#index"
  get 'items/:id' => "public/items#show", as: :item

  get 'current_customer/edit' => "public/customers#edit", as: :edit_current_customer
  get 'current_customer' => "public/customers#show", as: :current_customer
  patch 'current_customer' => "public/customers#update"
  get 'current_customer/leave' => "public/customers#leave"
  patch 'current_customer/withdraw' => "public/customers#withdraw"

  get 'cart_items' => "public/cart_items#index"
  post 'cart_items' => "public/cart_items#create"
  delete 'cart_items' => "public/cart_items#empty"
  patch 'cart_items/:id' => "public/cart_items#update", as: :cart_item
  delete 'cart_items/:id' => "public/cart_items#destroy"

  get 'orders' => "public/orders#index"
  post 'orders' => "public/orders#create"
  post 'orders/check' => "public/orders#check"
  get 'orders/thanks' => "public/orders#thanks"
  get 'orders/new' => "public/orders#new", as: :new_order
  get 'orders/:id' => "public/orders#show", as: :order

  get 'addresses' => "public/addresses#index"
  post 'addresses' => "public/addresses#create"
  get 'addresses/:id/edit' => "public/addresses#edit", as: :edit_address
  patch 'addresses/:id' => "public/addresses#update", as: :address
  delete 'addresses/:id' => "public/addresses#destroy"


  # ------------------------お店側のルート--------------------------

  namespace :admin do
    root to: "homes#top"
    resources :items, except:[:destroy]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update] do
      resources :order_items, only:[:update]
    end
  end
  devise_for :admins, path: :admin, controllers:{
    sessions:"admin/admins/sessions",
    registrations:"admin/admins/registrations",
    passwords:"admin/admins/passwords"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

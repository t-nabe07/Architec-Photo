Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  scope module: :public do
    root 'homes#top'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    put 'customers/withdraw' => 'customers#withdraw'

    resources :productions do
      resources :comments, only: [:create, :destroy]
      resource :goods, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :customers, only: [:show, :edit, :update] do
      get :favorites, on: :collection
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      get :favorites, on: :collection
    end

    delete 'notifications/all_destroy' => 'notifications#all_destroy'
    resources :notifications, only: :index

  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions",
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :productions, only: [:index, :show]
  end
end

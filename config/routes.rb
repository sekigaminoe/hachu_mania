Rails.application.routes.draw do
  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:index, :show] do
      resources :post_comments, only: [:destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end
  #ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    resources :users, only: [:show, :edit, :update, :index] do
      member do
        get "users/confirm" => "users#confirm"
        patch "users/withdrawal" => "users#withdrawal"
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :groups do
      resource :group_users, only: [:create, :destroy]
      resources :event_notices, only: [:new, :create]
      get "event_notices" => "event_notices#sent"
    end
    get "search" => "posts#search"
    get '/genre/search' => 'searches#genre_search'
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

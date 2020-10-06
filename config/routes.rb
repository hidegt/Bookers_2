Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#top"

  #マイページ用ルート
  resources :users, :only => [:show, :index, :edit, :update] do
    member do
      get :follow, :follower
    end
    resource :relationships, only: [:create, :destroy]
  end
  #ブック用ルート
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  #ヘッダーリンク
  get "home/about" => "homes#about"
  #search
  get "/search" => "search#search"
end

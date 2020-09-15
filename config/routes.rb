Rails.application.routes.draw do
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#top"
  
  #マイページ用ルート
  resources :users, :only => [:show, :index, :edit, :update]
  #ブック用ルート
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  
  #ヘッダーリンク
  get "home/about" => "homes#about"
  #root 'books#index'
end

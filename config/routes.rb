Rails.application.routes.draw do
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#top"
  
  #マイページ用ルート
  # :index
  resources :users, :only => [:show, :edit, :update]
  #ブック用ルート
  # :edit :update :deleate
  resources :books, only: [:new, :create, :index, :show]
  
  #ヘッダーリンク
  get "home/about" => "homes#about"
  #root 'books#index'
end

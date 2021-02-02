Rails.application.routes.draw do
  resources :candidates do
    resources :rooms, only: [:show] do
      resources :messages, only:[:create] 
    end  
  end
  resources :votes, only: [:index, :create, :new]
  
  root to: 'tops#index'
  devise_for :electorates
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

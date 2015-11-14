Rails.application.routes.draw do
    resources :users
    resources :groups do
      member do
        get 'join'
      end
    end
    get 'signup' => 'users#new'
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get 'welcome/index'


    root 'welcome#index'

end

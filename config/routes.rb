Rails.application.routes.draw do
    
    root 'pages#home'
    get     'signup'        => 'users#new'
    get     'login'         => 'sessions#new'
    post    'login'         => 'sessions#create'
    delete  'logout'        => 'sessions#destroy'
    get     'join'          => 'members#create'
    get     'groups/match'  

    resources :microposts
    resources :users
    resources :groups do
        collection do
            get 'join'
            get 'leave'
        end
    end

end

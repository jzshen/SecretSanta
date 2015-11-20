Rails.application.routes.draw do
    
    root 'pages#home'
    get     'signup'            => 'users#new'
    get     'login'             => 'sessions#new'
    post    'login'             => 'sessions#create'
    delete  'logout'            => 'sessions#destroy'
    get     'join'              => 'membership#create'
    get     'groups/mymatch'    => 'groups#mymatch'
    post    'groups/match'       => 'groups#match'
    post    'groups/unmatch'    => 'groups#unmatch'

    resources :microposts
    resources :users
    resources :groups do
        collection do
            get 'join'
            get 'leave'
        end
    end

end

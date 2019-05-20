Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'pages#home'
  get 'about', to: 'pages#about'


  # This one line gave us:
  # a new article path
  # post, to create articles
  # an edit article path
  # a patch, to update articles
  # a delete article path
  # show article path
  # index article path
  resources :articles

  get 'signup', to: 'users#new'

  # The except argument tells Rails that we want all the routes except the users#new route,
  # which we already have as "signup".
  resources :users, except: [:new]

  # This is another possible fix if we don't want to use the resources method. See lecture 119.
  # post 'users', to: 'users#create'


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end

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



end

Rails.application.routes.draw do
  get 'cocorocos/new'

  get 'cocorocos/create'

  get 'cocorocos/show'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :cocorocos, only: %i[new index create show]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

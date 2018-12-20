Rails.application.routes.draw do
  resources :cocorocos, only: %i[new index create show]

  post 'run' => 'application#run', as: 'run'
  post 'stop' => 'application#stop', as: 'stop'
  root to: 'application#edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

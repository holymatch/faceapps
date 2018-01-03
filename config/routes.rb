Rails.application.routes.draw do
  resources :people
  post 'face/recognize'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

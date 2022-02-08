Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :categories

  # para indicar que se abra el index de Task cuando se accede al directorio raiz en el navegador osea -> localhost:3000
  root 'tasks#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

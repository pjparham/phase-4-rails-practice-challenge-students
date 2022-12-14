Rails.application.routes.draw do
  resources :instructors
  resources :students

  # get '/instructors', to: 'instructors#index'
  # get '/students', to: 'students#index'
end

Rails.application.routes.draw do

  resources :listings do
    resources :orders, only: [ :new, :create ]
  end

  resources :categories

  root 'landings#index'
  get '/about' => 'landings#about'
  get '/contact' => 'landings#contact'
  # get 'seller' => "listings#seller"
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"

  # these routes are for showing users a login form, logging them in, and logging them out.
  get     '/login'       =>     'sessions#new'
  post    '/login'       =>     'sessions#create'
  get     '/logout'     =>     'sessions#destroy'

  # these routes will be for signup. The first renders a form in the browse, the second will
  # receive the form and create a user in our database using the data given to us by the user.
  get     '/signup'    =>     'users#new'
  post    '/users'      =>    'users#create'

end

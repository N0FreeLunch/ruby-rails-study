Rails.application.routes.draw do
  get 'view_to_display/sampleView'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'test' => proc { |env| [200, {}, ['Hello, world!']] }
  get 'welcome' => 'page#home'
end

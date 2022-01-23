Rails.application.routes.draw do
  namespace :api do
    get 'topic_tags' => 'topic_tags#index'
    resources :problems, except: [:new, :edit]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

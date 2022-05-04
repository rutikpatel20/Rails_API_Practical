Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles do
        collection do
          get :article_title_search
        end
      end
      resources :article_comments do
        collection do
          get :comment_search
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

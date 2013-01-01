Books::Application.routes.draw do

  resources :exports, :only => [:new, :create]

  resources :imports, :only => [:new, :create] do
    collection do
      get 'export'
    end
  end

  resources :books, :only => [:index, :show] do
    collection do
      get 'find'
      get 'autocomplete_book_title'
      get 'autocomplete_book_author'
      get 'autocomplete_book_publisher'
      get 'autocomplete_book_category'
    end
  end

  match '/home/readme', :to => "home#readme"

  root :to => 'books#index'

end

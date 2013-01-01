Books::Application.routes.draw do

  resources :books, :only => [:index, :show] do
    collection do
      get 'find'
      get 'autocomplete_book_title'
      get 'autocomplete_book_author'
      get 'autocomplete_book_publisher'
      get 'autocomplete_book_category'
    end
  end

  resources :imports, :only => [:new, :create] do
    collection do
      get 'export'
    end
  end

  root :to => 'books#index'

end

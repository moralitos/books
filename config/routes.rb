Books::Application.routes.draw do

  resources :books, :only => [:index, :show] do
    collection do
      get 'find'
    end
  end

  resources :imports, :only => [:new, :create] do
    collection do
      get 'export'
    end
  end

  root :to => 'books#index'

end

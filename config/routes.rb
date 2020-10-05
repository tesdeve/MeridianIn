Rails.application.routes.draw do

  root "employees#index"
  resources :employees do
    collection { post :import
               delete 'remove_all'}
  end  

  get 'search', to: 'employees#search'
  get 'total_checked_in_pdf', to: 'employees#total_checked_in_pdf'  
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
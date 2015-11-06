Rails.application.routes.draw do
  root :to => "home#index"

  get 'search' => 'home#search_info', as: :search
  get 'show_info/:id' => 'home#show_info', as: :show_info
end

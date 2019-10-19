Rails.application.routes.draw do
  resources :calculations

  root to: "calculations#new"
end

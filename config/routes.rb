Rails.application.routes.draw do
  get 'static_pages/help'

  get 'static_pages/home'

  root 'application#hello'
end

Rails.application.routes.draw do
  root to: 'repos#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  get '/:owner/:repo/' => 'repos#show', as: :show_repo
end

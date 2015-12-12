Rails.application.routes.draw do
  root to: 'repos#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  get '/repos/_index' => 'repos#index_partial', as: :repos_partial
  get '/:owner/:repo/' => 'repos#show', as: :show_repo
  get '/:owner/:repo/:user' => 'users#show', as: :user_report
end

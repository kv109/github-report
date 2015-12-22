Rails.application.routes.draw do
  root to: 'repos#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  get '/repos/index' => 'repos#index', as: :repos
  get '/:owner/:repo/' => 'repos#show', as: :show_repo
  get '/:owner/:repo/contributors' => 'repos#contributors', as: :repo_contributors
  get '/:owner/:repo/:user' => 'users#show', as: :user_report
end

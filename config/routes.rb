Rails.application.routes.draw do
  root to: 'repos#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  get '/repos/index/_' => 'repos#index_partial', as: :repos_partial
  get '/:owner/:repo/' => 'repos#show', as: :show_repo
  get '/:owner/:repo/_' => 'repos#show_partial', as: :show_repo_partial
  get '/:owner/:repo/:user' => 'users#show', as: :user_report
end

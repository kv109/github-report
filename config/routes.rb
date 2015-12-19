Rails.application.routes.draw do
  root to: 'repos#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  get '/repos/index' => 'repos#index', as: :repos
  get '/:owner/:repo/' => 'repos#show', as: :show_repo
  get '/:owner/:repo/_' => 'repos#show_partial', as: :show_repo_partial
  get '/:owner/:repo/:user' => 'users#show', as: :user_report
  get '/:owner/:repo/:user/_' => 'users#show_partial', as: :user_report_partial
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :set_client

  def set_client
    @client = Octokit::Client.new(:access_token => current_user.token) if current_user
  end

  def current_repo
    params[:repo]
  end
  helper_method :current_repo

  def current_repo_owner
    params[:owner]
  end
  helper_method :current_repo_owner

  def current_collaborator
    params[:user]
  end
  helper_method :current_collaborator

  def current_repo!
    params.fetch(:repo)
  end
  helper_method :current_repo!

  def current_repo_owner!
    params.fetch(:owner)
  end
  helper_method :current_repo_owner!

  def current_repo_full_name!
    "#{current_repo_owner!}/#{current_repo!}"
  end
  helper_method :current_repo_owner!

  def current_collaborator!
    params.fetch(:user)
  end
  helper_method :current_collaborator!
end

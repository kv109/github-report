class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :set_client

  def set_client
    @client = Octokit::Client.new(:access_token => current_user.token) if current_user
  end
end

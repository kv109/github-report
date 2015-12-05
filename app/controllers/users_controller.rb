class UsersController < ApplicationController
  def show
    render plain: current_collaborator!
  end
end

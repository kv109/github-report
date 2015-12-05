class UsersController < ApplicationController
  def show
    @commits = Commit.new(@client).by_repo_user_and_date(current_repo_full_name!, current_collaborator!).get
    @events  = []
    # @events = Event.by_organization_and_user.get
  end
end

class UsersController < ApplicationController
  def show
    @commits = Commit.new(@client).by_repo_and_user_and_date(current_repo_full_name!, current_collaborator!).get
    @comments  = Comment.new(@client).by_repo_and_date(current_repo_full_name!, Date.today).get
  end

  private

  def add_breadcrumbs
    [
        [current_repo!, show_repo_path(current_repo_owner!, current_repo!)],
        [current_collaborator!, user_report_path(current_repo_owner!, current_repo!, current_collaborator!)]
    ]
  end

end

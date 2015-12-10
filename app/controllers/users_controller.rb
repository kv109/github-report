class UsersController < ApplicationController
  before_action :set_date, only: [:show]

  def show
    commits  = Commit.new(@client).by_repo_and_user_and_date(current_repo_full_name!, current_collaborator!, @date).get
    issue_comments = IssueComment.new(@client).by_repo_and_date(current_repo_full_name!, @date).where(author: current_collaborator!).get
    code_review_comments = Comment.new(@client).by_repo(current_repo_full_name!).get

    @view = UsersShowView.new(commits, issue_comments, code_review_comments)
  end

  private

  def add_breadcrumbs
    [
        [current_repo!, show_repo_path(current_repo_owner!, current_repo!)],
        [current_collaborator!, user_report_path(current_repo_owner!, current_repo!, current_collaborator!)]
    ]
  end

  def set_date
    @date = if params[:date]
      Date.parse(params[:date])
    else
      Date.today
    end
  end

end

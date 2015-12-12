class UsersController < ApplicationController
  before_action :set_date, only: [:show, :show_partial]

  def show
  end

  def show_partial
    map = {
        commits: Commit.new(@client).by_repo_and_user_and_date(current_repo_full_name!, current_collaborator!, @date),
        issue_comments: IssueComment.new(@client).by_repo_and_date(current_repo_full_name!, @date).where(author: current_collaborator!),
        code_review_comments: Comment.new(@client).by_repo(current_repo_full_name!)
            .where(author: current_collaborator!)
            .where(date: @date)
    }
    threads = []

    map.each do |key, query|
      threads << Thread.new do
        map[key] = query.get
      end
    end

    threads.each(&:join)
    @view = UsersShowView.new(map.fetch(:commits), map.fetch(:issue_comments), map[:code_review_comments])

    render partial: 'show'
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

class UsersController < ApplicationController
  before_action :set_date, only: [:show, :show_partial]

  layout :ajaxify_layout, only: [:show]

  def show
    responses = multiple_requests(
        [
            Commit.new(@client).by_repo_and_user_and_date(current_repo_full_name!, current_collaborator!, @date),
            IssueComment.new(@client).by_repo_and_date(current_repo_full_name!, @date)
                .where(author: current_collaborator!)
                .where(date: @date),
            Comment.new(@client).by_repo(current_repo_full_name!)
                .where(author: current_collaborator!)
                .where(date: @date)
        ])
    @view = UsersShowView.new(*responses)
  end

  def three_months_report
    @stats = Stats.new(@client)
                         .by_repo(current_repo_full_name!)
                         .where(login: current_collaborator!)
                         .get

    @stats = @stats.map(&:component).map(&:to_h)
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

class ReposController < ApplicationController

  layout :ajaxify_layout, only: [:index, :show]

  def index
    @repos = Repo.new(@client).repos.get
  end

  def show
    @repo_full_name = current_repo_owner! + '/' + current_repo!
    @collaborators = Collaborator.new(@client)
                         .by_repo(@repo_full_name)
                         .where({ last_weeks_commits: 0 }, :>)
                         .get
  end

  def contributors
    @repo_full_name = current_repo_owner! + '/' + current_repo!
    @collaborators = Collaborator.new(@client)
                         .by_repo(@repo_full_name)
                         .where({ last_weeks_commits: 0 }, :>)
                         .get

    render partial: 'repos/contributors'
  end

  private

  def add_breadcrumbs
    return unless current_repo_owner
    [
        [current_repo!, show_repo_path(current_repo_owner!, current_repo!)]
    ]
  end
end

class ReposController < ApplicationController

  layout :ajaxify_layout, only: [:index]

  def index
    @repos = Repo.new(@client).repos.get
  end

  def show
  end

  def show_partial
    @repo_full_name = current_repo_owner! + '/' + current_repo!
    @collaborators = Collaborator.new(@client).by_repo(@repo_full_name)
                         .where({ last_weeks_commits: 0 }, :>)
                         .get
    render partial: 'repos/show'
  end

  private

  def add_breadcrumbs
    return unless current_repo_owner
    [
        [current_repo!, show_repo_path(current_repo_owner!, current_repo!)]
    ]
  end
end

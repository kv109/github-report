class ReposController < ApplicationController
  def index
  end

  def index_partial
    @repos = Repo.new(@client).repos.get
    render partial: 'repos/index'
  end

  def show
  end

  def show_partial
    @repo_full_name = current_repo_owner! + '/' + current_repo!
    @collaborators = Collaborator.new(@client).by_repo(@repo_full_name).get
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

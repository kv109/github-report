class ReposController < ApplicationController
  def index
    @repos = Repo.new(@client).repos.get
  end

  def show
    @repo_full_name = current_repo_owner! + '/' + current_repo!
    @collaborators = Collaborator.new(@client).by_repo(@repo_full_name).get
  end
end

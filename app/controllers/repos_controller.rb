class ReposController < ApplicationController
  def index
    @repos = Repo.new(@client).repos.get
  end

  def show
    @collaborators = Collaborator.new(@client).by_repo(params.fetch(:repo)).get
    @current_repo = params.fetch(:repo)
  end
end

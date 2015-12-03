class Collaborator

  include Query

  def by_repo(repo)
    @query = [:collaborators, repo]
    self
  end

  private

  class Item < Sawyer::Resource
    include Decorator
  end
end
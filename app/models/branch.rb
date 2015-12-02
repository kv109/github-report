class Branch

  include Query

  def by_repo(repo)
    @query = [:branches, repo]
    self
  end

  private

  class Item < Sawyer::Resource
    include Decorator
  end
end
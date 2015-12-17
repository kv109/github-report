class Branch

  include Resource

  def by_repo(repo)
    @query = [:branches, repo]
    self
  end

  class Item
    include Decorator
  end
end
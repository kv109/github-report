class Branch

  include Resource

  def by_repo(repo)
    @query = [:branches, repo]
    self
  end

  private

  class Item
    include Decorator
  end
end
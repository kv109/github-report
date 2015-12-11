class Repo

  include Query

  def repos
    @query = [:repos, nil, per_page: 200]
    self
  end

  private

  class Item
    include Decorator
  end
end
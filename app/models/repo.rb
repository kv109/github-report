class Repo

  include Resource

  def repos
    @query = [:repos, nil, per_page: 200, sort: :pushed]
    self
  end

  class Item
    include Decorator
  end
end
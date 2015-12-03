class Repo

  include Query

  def repos
    @query = [:repos]
    self
  end

  private

  class Item < Sawyer::Resource
    include Decorator
  end
end
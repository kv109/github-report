class Branch
  class << self
    def by_repo
      @collection = Octokit.branches(repo)
      self
    end

    def get
      @collection.map(&method(:to_item))
    end

    def to_item(resource)
      Item.new(resource)
    end

    private

    def repo
      ENV.fetch('GITHUB_REPO')
    end
  end

  class Item < Sawyer::Resource
    include Decorator
  end
end
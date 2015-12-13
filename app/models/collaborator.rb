class Collaborator

  include Query

  def by_repo(repo)
    @query = [:contributors_stats, repo]
    self
  end

  def send_query(query)
    super.reverse
  end

  private

  class Item
    include Decorator

    def login
      author.login
    end
  end
end
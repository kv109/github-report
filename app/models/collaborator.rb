class Collaborator

  include Resource

  def by_repo(repo)
    @query = [:contributors_stats, repo]
    self
  end

  def send_query(query)
    super.reverse
  end

  class Item
    include Decorator

    def login
      author.login
    end

    def last_weeks_commits(last = 2)
      last_weeks_data(last).map { |week| week[:c] }.sum
    end

    def last_weeks_data(last = 2)
      weeks.last(last)
    end
  end
end
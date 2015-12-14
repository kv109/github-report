class IssueComment

  include Resource

  def by_repo_and_date(repo, date)
    @query = [:issues_comments, repo, since: date]
    self
  end

  class Item
    include Decorator

    def author
      user.login
    end

    def date
      created_at.to_date
    end
  end
end
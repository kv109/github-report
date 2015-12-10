class IssueComment

  include Query

  def by_repo_and_date(repo, date)
    @query = [:issues_comments, repo, since: date]
    self
  end

  class Item < Sawyer::Resource
    include Decorator

    def author
      user.login
    end
  end
end
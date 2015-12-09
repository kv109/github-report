class Comment

  include Query

  def by_repo_and_date(repo, date)
    @query = [:issues_comments, repo, since: date]
    self
  end

  class Item < Sawyer::Resource
    include Decorator
  end
end
class Issue

  include Query

  def comments_by_repo_and_date(repo, date)
    @query = [:issues_comments, repo, since: date]
    self
  end

  class Item < Sawyer::Resource
    include Decorator
  end
end
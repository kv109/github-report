class Comment

  include Query

  def by_repo(repo)
    @query = [:repository_events, repo]
    self
  end

  def send_query(query)
    super.select(&:code_review_comment?)
  end

  class Item < Sawyer::Resource
    CODE_REVIEW_TYPES = %w(PullRequestReviewCommentEvent)

    include Decorator

    def code_review_comment?
      type.in? CODE_REVIEW_TYPES
    end
  end
end
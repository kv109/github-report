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

    def body
      payload.comment.body
    end

    def html_url
      payload.comment.html_url
    end

    def author
      actor.login
    end

    def date
      created_at.to_date
    end
  end
end

class UsersShowView
  attr_reader :commits, :issue_comments, :code_review_comments

  def initialize(commits, issue_comments, code_review_comments)
    @commits = commits.uniq(&:sha)
    @issue_comments = issue_comments
    @code_review_comments = code_review_comments
  end

  def all_comments
    @all_comments ||= (issue_comments + code_review_comments).sort_by(&:created_at).reverse
  end

  def commits_grouped_by_issue
    grouped = commits.group_by(&:issue_number)

    grouped.each do |array|
      array[1] = sort_commits_by_created_at(array[1])
    end

    grouped.sort do |a, b|
      newest_commit = a[1][0]
      other_newest_commit = b[1][0]
      other_newest_commit.created_at <=> newest_commit.created_at
    end
  end

  private

  def sort_commits_by_created_at(commits)
    commits.sort_by(&:created_at).reverse
  end
end

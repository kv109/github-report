class Commit

  include Query

  def by_repo_and_user_and_date(repo, user, date = 24.hours.ago)
    @queries = branches(repo).map(&:name).map do |branch|
      [:commits_since, repo, date, branch, author: user]
    end
    self
  end

  def branches(repo)
    Branch.new(client).by_repo(repo).get#[0..2]
  end

  def send_query(query)
    super.reject(&:merge_commit?)
  end

  class Item < Sawyer::Resource

    include Decorator

    def issue_html_url
      return unless issue_number

      base_url = html_url.partition('/commit')[0]
      [base_url, 'issues', issue_number].join('/')
    end

    def <=>(other)
      return 1 unless issue_number
      return -1 unless other.issue_number
      issue_number <=> other.issue_number
    end

    def committer
      commit.committer
    end

    def committer_name
      committer.name
    end

    def created_at
      committer.date
    end

    def issue_number
      match = commit.message.match(/#(\d+)/)
      match[1] if match
    end

    def merge_commit?
      commit.message.match(/Merge/)
    end

    def commit_message
      commit.message
    end
  end
end
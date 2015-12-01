class Commit
  class << self

    def by_date(date = 1.days.ago)
      @collection = Octokit.commits_on(repo, date).map(&method(:to_item)).reject(&:merge_commit?)
      self
    end

    def to_item(resource)
      Item.new(resource)
    end

    def repo
      ENV.fetch('GITHUB_REPO')
    end

    def get
      @collection.map(&method(:to_item))
    end

  end

  class Item < Sawyer::Resource

    include Decorator

    def issue_html_url
      "https://github.com/#{Commit.repo}/issues/#{issue_number}" if issue_number
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
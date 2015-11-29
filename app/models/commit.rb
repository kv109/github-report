class Commit
  class << self

    def by_date(date = Date.today)
      Octokit.commits_on(repo, date)
    end

    private

    def repo
      ENV.fetch('GITHUB_REPO')
    end

  end
end
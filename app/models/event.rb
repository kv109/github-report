class Event
  class << self
    def by_organization_and_user
      @collection = Octokit.paginate("#{base_uri}orgs/#{org}", per_page: 1000)
      self
    end

    def issues
      @collection.map(&method(:to_item)).select(&:issues_event?)
    end

    def to_item(resource)
      Item.new(resource)
    end

    def get
      @collection
    end

    private

    def base_uri
      "#{Octokit::User.path login}/events/"
    end

    def login
      @login ||= Octokit.user.login
    end

    def org
      ENV['GITHUB_ORG']
    end
  end

  class Item < Sawyer::Resource
    include Decorator

    def issues_event?
      type == 'IssuesEvent'
    end
  end
end
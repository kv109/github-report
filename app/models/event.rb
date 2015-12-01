class Event
  def self.by_organization_and_user
    @collection = Octokit.paginate("#{base_uri}orgs/#{org}", per_page: 1000)
    self
  end

  def self.issues
    @collection.map(&method(:to_item)).select(&:issues_event?)
  end

  def self.to_item(resource)
    Item.new(resource)
  end

  def self.get
    @collection
  end

  private

  def self.base_uri
    "#{Octokit::User.path login}/events/"
  end

  def self.login
    @login ||= Octokit.user.login
  end

  def self.org
    ENV['GITHUB_ORG']
  end

  class Item < Sawyer::Resource
    include Decorator

    def issues_event?
      type == 'IssuesEvent'
    end
  end
end
class WelcomeController < ApplicationController

  def index
    @commits = Commit.new(@client).by_repo_and_date(Query.repo).get
    @events = []
    # @events = Event.by_organization_and_user.get
  end

end

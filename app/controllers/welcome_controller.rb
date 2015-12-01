class WelcomeController < ApplicationController

  def index
    @commits = Commit.by_date.get
    @events = []
    # @events = Event.by_organization_and_user.get
  end

end

class WelcomeController < ApplicationController

  def index
    @events = Octokit.user_events(Octokit.user.login)
  end

  private

end

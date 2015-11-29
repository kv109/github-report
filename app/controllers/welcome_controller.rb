class WelcomeController < ApplicationController

  def index
    @commits = Commit.by_date
  end

end

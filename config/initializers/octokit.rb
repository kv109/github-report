module Octokit
  module Configurable
    attr_accessor :wait_for_stats
  end
end

module Octokit
  class Client
    class << self
      def keys
        super << :wait_for_stats
      end
    end
  end
end

module Octokit
  class Client
    module Stats

      def get_stats(repo, metric, options = {})
        request = -> { get_stats_data(repo, metric, options = {}) }
        data = request.call

        if Octokit.wait_for_stats
          time_left = Octokit.wait_for_stats.to_i
          interval = time_left / 10.0

          while last_response.status == 202 && time_left > 0 do
            sleep interval
            data = request.call
            time_left -= interval
          end
        end

        data
      end

      def get_stats_data(repo, metric, options = {})
        get("#{Repository.path repo}/stats/#{metric}", options)
      end

    end
  end
end

Octokit.configure do |c|
  c.client_id = ENV['GITHUB_KEY']
  c.client_secret = ENV['GITHUB_SECRET']

  c.wait_for_stats = 2.seconds
end

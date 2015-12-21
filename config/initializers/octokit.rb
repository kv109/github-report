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
        if Octokit.wait_for_stats
          get_stats_data_patiently(repo, metric, options)
        else
          get_stats_data(repo, metric, options)
        end.tap do
          return nil if cache_not_ready?
        end
      end

      def get_stats_data_patiently(repo, metric, options = {})
        data = nil
        time_start = Time.now

        loop do
          data = get_stats_data(repo, metric, options)
          timeout = Time.now - time_start > Octokit.wait_for_stats
          break if cache_ready? || timeout
          sleep 0.1
        end

        data
      end

      def cache_not_ready?
        last_response.status == 202
      end

      def cache_ready?
        last_response.status == 200
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

stack = Faraday::RackBuilder.new do |builder|
  builder.response :logger
  builder.use Octokit::Response::RaiseError
  builder.use Faraday::HttpCache
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack

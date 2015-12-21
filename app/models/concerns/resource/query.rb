class Resource::Query
  attr_reader :query

  def initialize(client, query)
    @client = client
    @query = query
  end

  def results
    results = retrieve_results_from_github
    if results.nil?
      results = []
    else
      results = results.map(&:to_hash)
    end
    results
  end

  private

  def retrieve_results_from_github
    @client.send(*query)
  rescue Octokit::NotFound => e
    Rails.logger.warn e.message
    []
  end
end

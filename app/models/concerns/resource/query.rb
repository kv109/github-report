class Resource::Query
  attr_reader :query

  def initialize(client, query)
    @client = client
    @query = query
  end

  def results
    return cached_results unless cached_results.nil?

    results = retrieve_results_from_github
    if results.nil?
      results = []
    else
      results = results.map(&:to_hash)
    end
    results.tap do
      write_query_to_cache(results)
    end
  end

  private

  def retrieve_results_from_github
    @client.send(*query)
  rescue Octokit::NotFound => e
    Rails.logger.warn e.message
    []
  end

  def write_query_to_cache(results)
    results = :empty_array if results == []
    Rails.cache.write(cache_key, results)
  end

  def cached_results
    cached_results = Rails.cache.read(cache_key)
    cached_results = [] if cached_results == :empty_array
    cached_results
  end

  def cache_key
    @query_cache_key ||= query.map do |param|
      if param.is_a?(Hash)
        param.keys.join + param.values.join
      else
        param.to_s
      end
    end.tap do |arr|
      arr.insert(0, @client.user.id.to_s)
    end.join('+')
  end

end

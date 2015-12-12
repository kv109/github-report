module Query
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def get
    if @query
      send_query(@query)
    elsif @queries
      send_multiple_queries(@queries)
    end
  end

  def where(hash)
    conditions << hash
    self
  end

  private

  def conditions
    @conditions ||= []
  end

  def send_multiple_queries(queries)
    threads, results = [], []

    queries.map do |query|
      threads << Thread.new do
        results.concat send_query(query)
      end
    end

    threads.each(&:join)
    results
  end

  def send_query(query)
    key = query_cache_key(query)
    cached_results = read_cache_from_query(key)
    return filter_results(cached_results) unless cached_results.nil?

    client.send(*query)
        .map(&:to_hash).tap do |hashes|
          write_query_to_cache(key, hashes)
        end.map(&method(:to_item)).tap do |results|
          filter_results(results)
        end
  rescue Octokit::NotFound => e
    Rails.logger.warn e.message
    return []
  end

  def filter_results(results)
    if conditions.present?
      conditions.each do |condition|
        condition.each do |key, value|
          results.select! do |result|
            result.send(key) == value
          end
        end
      end
    end
    results
  end

  def write_query_to_cache(key, results)
    results = :empty_array if results == []
    Rails.cache.write(key, results)
  end

  def read_cache_from_query(key)
    cached_results = Rails.cache.read(key)
    return nil if cached_results.nil?
    return [] if cached_results == :empty_array
    cached_results.map(&method(:to_item))
  end

  def query_cache_key(query)
    query.map do |param|
      if param.is_a?(Hash)
        param.keys.join + param.values.join
      else
        param.to_s
      end
    end.tap do |arr|
      arr.insert(0, @client.user.id.to_s)
    end.join('+')
  end

  def to_item(resource_hash)
    self.class::Item.new(OpenStruct.new(resource_hash))
  end
end

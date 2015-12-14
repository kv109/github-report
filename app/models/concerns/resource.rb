module Resource
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

  def send_query(query_params)
    Query.new(client, query_params).results.map(&method(:to_item)).tap do |results|
      filter_results(results)
    end
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

  def to_item(resource_hash)
    self.class::Item.new(OpenStruct.new(resource_hash))
  end
end

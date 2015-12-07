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
    client.send(*query).map(&method(:to_item))
  end

  def to_item(resource)
    self.class::Item.new(resource)
  end

  def self.repo
    ENV['GITHUB_REPO']
  end

end
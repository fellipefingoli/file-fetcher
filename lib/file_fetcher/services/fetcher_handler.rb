module FileFetcher::Services
  class FetcherHandler
    attr_accessor :fetchers
    attr_reader :fetcher_builder

    def initialize(fetcher_builder, options={})
      @fetcher_builder = fetcher_builder
      @fetchers = []
    end

    def build(resources, &block)
      resources.each do |resource|
        yield fetcher_builder
        fetcher_builder.set_resource(resource)
        fetchers << fetcher_builder.fetcher
        fetcher_builder.reset
      end
    end

    def fetch_all(&block)
      fetchers.map do |fetch|
        yield fetch
        OpenStruct.new({
          resource: fetch.resource,
          fetched: fetch.fetched?
        })
      end
    end
  end
end
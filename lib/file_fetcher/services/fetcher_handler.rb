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
        fetcher_builder.set_resource(resource)
        yield fetcher_builder
        fetchers << fetcher_builder.fetcher
        fetcher_builder.reset
      end
    end

    def fetch_all(&block)
      fetchers.map do |fetcher|
        fetch(fetcher, &block)
      end
    end

    def fetch_all_async(&block)
      fetchers.map do |fetcher|
        Thread.new { fetch(fetcher, &block) }
      end
    end

    def fetch(fetcher, &block)
      yield fetcher
      OpenStruct.new({
        resource: fetcher.resource,
        fetched: fetcher.fetched?
      })
    end
  end
end
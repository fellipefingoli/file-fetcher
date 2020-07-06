module FileFetcher::Services
  class FetcherHandler
    attr_accessor :fetchers
    attr_reader :fetcher_builder, :request_type, :dispatch_type

    def initialize(fetcher_builder, options)
      @fetcher_builder = fetcher_builder
      @fetchers = []
      @request_type = options.fetch(:request_type, 'http')
      @dispatch_type = options.fetch(:dispatch_type, 'local')
    end

    def build(resources)
      resources.each do |resource|
        fetcher_builder.set_resource(resource)
        fetcher_builder.set_requester(request_type)
        fetcher_builder.set_dispatcher(dispatch_type)
        fetchers << fetcher_builder.fetcher
      end
    end

    def fetch_all
      fetchers.map do |fetch|
        fetch.request
        fetch.dispatch
        OpenStruct.new({
          resource: fetch.resource,
          fetched: fetch.fetched?
        })
      end
    end
  end
end
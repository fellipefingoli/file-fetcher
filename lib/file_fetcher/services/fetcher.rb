module FileFetcher::Services
  class Fetcher
    attr_accessor :fetcher_resource, :requester, :dispatcher

    def initialize(fetcher_resource, requester, dispatcher)
      @fetcher_resource = fetcher_resource
      @requester = requester
      @dispatcher = dispatcher
    end

    def fetch_file
      tempfile_path = requester.request_file(fetcher_resource.from_path).tempfile_path
      result = dispatcher.dispatch_file(tempfile_path, fetcher_resource.to_path)
      @fetched = result.dispatched
    end

    def fetched?
      @fetched || false
    end
  end
end
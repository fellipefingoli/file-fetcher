module FileFetcher::Services
  class Fetcher
    attr_accessor :resource, :requester, :dispatcher,

    def request
      @tempfile_path = requester.request_file(resource.from_path).tempfile_path
    end

    def dispatch
      result = dispatcher.dispatch_file(@tempfile_path, resource.to_path)
      @fetched = result.dispatched
    end

    def fetched?
      @fetched || false
    end
  end
end
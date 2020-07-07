module FileFetcher::Services
  class Fetcher
    attr_accessor :resource, :requester, :dispatcher,

    def self.create(resource:, requester:, dispatcher:)
      fetcher = self.new
      fetcher.resource = resource
      fetcher.requester = requester
      fetcher.dispatcher = dispatcher
      fetcher
    end

    def request(options={})
      @tempfile_path = requester.request_file(resource.from_path, options).tempfile_path
    end

    def dispatch(options={})
      result = dispatcher.dispatch_file(@tempfile_path, resource.to_path, options)
      @fetched = result.persisted
    end

    def fetched?
      @fetched || false
    end
  end
end
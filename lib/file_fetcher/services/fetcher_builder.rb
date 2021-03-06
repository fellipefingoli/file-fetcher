module FileFetcher::Services
  class FetcherBuilder
    def fetcher
      @fetcher ||= Fetcher.new
    end

    def reset
      @fetcher = Fetcher.new
    end

    def set_resource(resource)
      fetcher.resource = resource
    end
    
    def set_requester(type)
      fetcher.requester = "FileFetcher::Services::Requesters::#{type.capitalize}".constantize.new
    end

    def set_dispatcher(type)
      fetcher.dispatcher = "FileFetcher::Services::Dispatchers::#{type.capitalize}".constantize.new
    end
  end
end
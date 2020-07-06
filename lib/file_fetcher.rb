require "file_fetcher/version"

module FileFetcher
  module Models
    autoload :FetcherResource, "file_fetcher/models/fetcher_resource"
  end

  module Services
    module Dispatchers
      autoload :Local, "file_fetcher/services/dispatchers/local"
    end

    module Readers
      autoload :RawText, "file_fetcher/services/readers/raw_text"
    end

    module Requesters
      autoload :Http, "file_fetcher/services/requesters/http"
    end

    autoload :Fetcher, "file_fetcher/services/fetcher"
    autoload :FetcherBuilder, "file_fetcher/services/fetcher_builder"
    autoload :FetcherHandler, "file_fetcher/services/fetcher_handler"
  end
  class Error < StandardError; end
  # Your code goes here...
end

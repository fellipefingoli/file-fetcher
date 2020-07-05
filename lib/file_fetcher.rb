require 'active_support'

require "file_fetcher/version"

module FileFetcher
  module Models
    autoload :FetcherResource, "file_fetcher/models/fetcher_resource"
  end

  module Services
    autoload :HttpRequest, "file_fetcher/services/http_request"

    module FileReader
      autoload :RawText, "file_fetcher/services/file_reader/raw_text"
    end
  end
  class Error < StandardError; end
  # Your code goes here...
end

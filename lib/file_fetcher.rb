require "active_model"
require "active_support"
require "active_support/core_ext/string/inflections.rb"
require "ostruct"

require_relative "file_fetcher/api"
require_relative "file_fetcher/version"
require_relative "file_fetcher/models/fetcher_resource"
require_relative "file_fetcher/services/fetcher"
require_relative "file_fetcher/services/fetcher_builder"
require_relative "file_fetcher/services/fetcher_handler"
require_relative "file_fetcher/services/resources_handler"


module FileFetcher
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
  end
end

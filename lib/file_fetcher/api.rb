module FileFetcher::API
  extend self

  def fetch_and_dispatch(resource_paths, options={})
    options = set_options(options)
    resources_handler = set_resources_handler(resource_paths, options)  
    fetcher_builder = set_fetcher_builder()
    fetcher_handler = set_fetcher_handler(fetcher_builder, options)
    resources_handler.build

    fetcher_handler.build(resources_handler.resources) do |fetcher|
      fetcher.set_requester(options[:request_type])
      fetcher.set_dispatcher(options[:dispatch_type])
    end
    
    fetcher_handler.fetch_all do |fetcher|
      fetcher.request(options)
      fetcher.dispatch(options)
    end
  end

  private
    def set_options(options)
      %w(tempfile_path destination_path read_file reader_type request_type dispatch_type).each do |option|
        option = option.to_sym
        options[option] = options.fetch(option, default_options[option])
      end
      options
    end

    def set_resources_handler(resource_paths, options)
      options = options.slice(:read_file, :reader_type, :destination_path)
      FileFetcher::Services::ResourcesHandler.new(resource_paths, options)
    end

    def set_fetcher_builder
      FileFetcher::Services::FetcherBuilder.new
    end

    def set_fetcher_handler(fetcher_builder, options)
      FileFetcher::Services::FetcherHandler.new(fetcher_builder, options)
    end

    def default_options
      {
        tempfile_path: 'tmp/',
        destination_path: 'fetched_files/', 
        read_file: true,
        reader_type: 'raw_text',
        request_type: 'http',
        dispatch_type: 'local'
      }
    end
end
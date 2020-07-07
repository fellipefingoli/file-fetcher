module FileFetcher::API
  extend self

  def fetch_and_dispatch(resource_paths, options)
    resources_handler = FileFetcher::Services::ResourcesHandler.new(resource_paths, options) 
    resources_handler.build
    fetcher_builder = FileFetcher::Services::FetcherBuilder.new
    fetcher_handler = FileFetcher::Services::FetcherHandler.new(fetcher_builder, options)
    fetcher_handler.build(resources_handler.resources)
    fetcher_handler.fetch_all
  end
end
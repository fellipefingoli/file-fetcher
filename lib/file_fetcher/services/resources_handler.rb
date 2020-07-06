require "active_support"
require "active_support/core_ext/string/inflections.rb"

module FileFetcher::Services
  class ResourcesHandler
    attr_accessor :resource_paths, :read_file, :reader_type, :destination_path, :resources

    def initialize(resource_paths, options={})
      @resource_paths = resource_paths
      @read_file = options.fetch(:read_file, false)
      @reader_type = options.fetch(:reader_type, 'raw_text')
      @destination_path = options.fetch(:destination_path, 'files_fetched/')
      @resources = []
    end

    def build
      resource_paths = read_file_resource if read_file
      resource_paths.each do |resource_path|
        resource = FileFetcher::Models::FetcherResource.new({
          from_path: resource_path,
          to_path: destination_path
        })
        resources << resource if resource.valid?
      end
    end

    private
      def read_file_resource
        file_reader = "FileFetcher::Services::Readers::#{reader_type.camelize}".constantize.new
        file_reader.read_file(resource_paths)
      end
  end
end

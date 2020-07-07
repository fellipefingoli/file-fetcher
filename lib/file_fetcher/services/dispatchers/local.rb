require 'fileutils'

module FileFetcher::Services::Dispatchers
  class Local
    def dispatch_file(tempfile_path, destination_path, options={})
      destination_dir = File.dirname(destination_path)
      FileUtils.mkdir_p(destination_dir) unless File.directory?(destination_dir)
      FileUtils.mv(tempfile_path, destination_path)

      OpenStruct.new({
        destination_path: destination_path,
        persisted: true
      })
    end
  end
end
module FileFetcher::Services::FileDispatcher
  class Local
    attr_reader :tempfile_path

    def initialize(tempfile_path)
      @tempfile_path = tempfile_path
    end

    def dispatch_file(destination_path)
      file = File.open(tempfile_path, 'rb').read
      File.open(destination_path, 'wb').write file

      OpenStruct.new({ 
        destination_path: destination_path,
        persisted: true
      })
    end
  end
end
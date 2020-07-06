module FileFetcher::Services::Dispatchers
  class Local
    def dispatch_file(tempfile_path, destination_path)
      file = File.open(tempfile_path, 'rb').read
      File.open(destination_path, 'wb').write file

      OpenStruct.new({ 
        destination_path: destination_path,
        persisted: true
      })
    end
  end
end
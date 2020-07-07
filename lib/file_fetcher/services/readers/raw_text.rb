module FileFetcher::Services::Readers
  class RawText
    def read_file(file_path, options={})
      File.open(file_path, 'r').readlines.map(&:chomp)
    end
  end
end
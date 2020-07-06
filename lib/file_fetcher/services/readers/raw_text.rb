module FileFetcher::Services::Readers
  class RawText
    def read_file(file_path)
      File.open(file_path, 'r').readlines.map(&:chomp)
    end
  end
end
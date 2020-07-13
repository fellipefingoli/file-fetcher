module FileFetcher::Services::Readers
  class RawText
    def read_file(file_paths, options={}, &block)
      file_paths.flat_map do |file_path|
        File.open(file_path, 'r').readlines.map(&:chomp)
      end
    end
  end
end
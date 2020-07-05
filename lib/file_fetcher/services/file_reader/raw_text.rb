module FileFetcher::Services::FileReader
  class RawText
    attr_accessor :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def read_file
      File.open(file_path, 'r').readlines.map(&:chomp)
    end
  end
end
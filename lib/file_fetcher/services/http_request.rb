module FileFetcher::Services
  class HttpRequest
    require 'net/http'

    TEMPFILE_PATH = "spec/tmp/"

    attr_reader :uri

    def initialize(file_path)
      @uri = URI(file_path)
    end

    def request_file
      response = Net::HTTP.get_response(uri)
      tempfile = TEMPFILE_PATH + tempfile_name
      File.open(tempfile, 'wb').write response.body
    end

    private
      def tempfile_name
        time = Time.now
        "tempfile_#{time.to_i}#{time.nsec}#{rand(0..100)}"
      end
  end
end
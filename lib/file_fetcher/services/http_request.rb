module FileFetcher::Services
  class HttpRequest
    require 'net/http'

    TEMPFILE_NAME = -> { t = Time.now; "tempfile_#{t.to_i}#{t.nsec}" }
    TEMPFILE_PATH = "spec/tmp/"

    attr_reader :uri

    def initialize(file_path)
      @uri = URI(file_path)
    end

    def request_file
      response = Net::HTTP.get_response(uri)
      File.open( TEMPFILE_PATH + TEMPFILE_NAME.call, 'wb') do |file|
        file.write response.body
      end
    end
  end
end
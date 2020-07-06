module FileFetcher::Services::Requesters
  class Http
    require 'net/http'

    TEMPFILE_PATH = "spec/tmp/"
    
    def request_file(file_path)
      uri = URI(file_path)
      response = Net::HTTP.get_response(uri)
      tempfile = TEMPFILE_PATH + tempfile_name
      File.open(tempfile, 'wb').write response.body
      OpenStruct.new({ tempfile_path: tempfile })
    end

    private
      def tempfile_name
        time = Time.now
        "tempfile_#{time.to_i}#{time.nsec}#{rand(0..100)}"
      end
  end
end
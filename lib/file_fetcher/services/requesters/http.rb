require 'fileutils'
require 'net/http'

module FileFetcher::Services::Requesters
  class Http
    def request_file(file_path, options={})
      tempfile_path = options.fetch(:tempfile_path)
      uri = URI(file_path)
      response = Net::HTTP.get_response(uri)
      tempfile = tempfile_path + tempfile_name

      FileUtils.mkdir_p(tempfile_path) unless File.directory?(tempfile_path)

      File.open(tempfile, 'wb') do |file| 
        file.write response.body
        file.close
      end

      OpenStruct.new({ tempfile_path: tempfile })
    end

    private
      def tempfile_name
        time = Time.now
        "tempfile_#{time.to_i}#{time.nsec}#{rand(0..100)}"
      end
  end
end
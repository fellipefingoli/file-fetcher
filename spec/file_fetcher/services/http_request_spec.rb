require 'uri'

RSpec.describe FileFetcher::Services::HttpRequest do
  describe '#request_file' do
    let(:file_path) { 'https://cdn.bulbagarden.net/upload/thumb/2/21/001Bulbasaur.png/250px-001Bulbasaur.png' }
    let(:image_fixture) { File.open('spec/fixtures/image.png', 'r').read }
    let(:tempfile_path) { 'spec/tmp/tempfile_123' }

    subject { described_class.new(file_path) }

    before do
      stub_request(:get, file_path).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: image_fixture, headers: {})
      
      allow(subject).to receive(:tempfile_name).and_return('tempfile_123')
      
      subject.request_file
    end

    it 'write file in temporary path' do
      expect(File).to exist(tempfile_path)
    end

    it 'tempfile has same data from downloaded file' do
      expect(File.open(tempfile_path, 'r').read).to eq(image_fixture) 
    end

    after do
      File.delete(tempfile_path)
    end
  end
end
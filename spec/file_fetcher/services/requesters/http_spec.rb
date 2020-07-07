require 'uri'

RSpec.describe FileFetcher::Services::Requesters::Http do
  describe '#request_file' do
    let(:file_path) { 'https://cdn.bulbagarden.net/upload/thumb/2/21/001Bulbasaur.png/250px-001Bulbasaur.png' }
    let(:image_fixture) { File.open('spec/fixtures/image.png', 'r').read }
    let(:tempfile_path) { 'spec/tmp/tempfile_123' }

    subject { described_class.new }

    before do
      stub_request(:get, file_path).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: image_fixture, headers: {})

      allow(FileUtils).to receive(:mkdir_p)
      allow(FileUtils).to receive(:mv)
      allow(File).to receive(:open)
      allow(subject).to receive(:tempfile_name).and_return('tempfile_123')
    end

    it 'return tempfile_path in an object' do
      expect(subject.request_file(file_path, tempfile_path: File.dirname(tempfile_path) + '/').tempfile_path).to eq(tempfile_path)
    end
  end
end
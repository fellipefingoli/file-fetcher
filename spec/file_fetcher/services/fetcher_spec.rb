RSpec.describe FileFetcher::Services::Fetcher do
  let(:fetcher_resource) { double('File Resource', from_path: 'from/path', to_path: 'to/path') }
  let(:requester) { double('Requester') }
  let(:dispatcher) { double('Dispatcher') }

  subject { described_class.new(fetcher_resource, requester, dispatcher) }
  
  describe '#fetch_file' do
    before do
      allow(requester).to receive(:request_file).with('from/path').and_return(OpenStruct.new(tempfile_path: 'tempfile/path'))
      allow(dispatcher).to receive(:dispatch_file).with('tempfile/path','to/path').and_return(OpenStruct.new(persisted: true))
    end

    it 'request file' do
      expect(requester).to receive(:request_file).with('from/path')
      expect(dispatcher).to receive(:dispatch_file).with('tempfile/path','to/path')

      subject.fetch_file
    end
  end
end
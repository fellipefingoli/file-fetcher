RSpec.describe FileFetcher::Services::Fetcher do
  let(:resource) { double('File Resource', from_path: 'from/path', to_path: 'to/path') }
  let(:requester) { double('Requester') }
  let(:dispatcher) { double('Dispatcher') }

  subject do 
    described_class.create({
      resource: resource,
      requester: requester,
      dispatcher: dispatcher
    })
  end
  
  describe '#request' do
    before { allow(requester).to receive(:request_file).with('from/path').and_return(OpenStruct.new(tempfile_path: 'tempfile/path')) }

    it 'request file' do
      expect(requester).to receive(:request_file).with('from/path')

      subject.request
    end
  end

  describe '#dispatch' do
    before do
      subject.instance_variable_set(:@tempfile_path, 'tempfile/path')
      allow(dispatcher).to receive(:dispatch_file).with('tempfile/path','to/path').and_return(OpenStruct.new(persisted: true))
    end

    it 'dispatch file' do
      expect(dispatcher).to receive(:dispatch_file).with('tempfile/path','to/path')

      subject.dispatch
    end
  end

  describe '#fetched?' do
    it { expect(subject.fetched?).to be false }
  end
end
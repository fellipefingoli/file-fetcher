RSpec.describe FileFetcher::Services::ResourcesHandler do
  let(:resource_path) { 'path/to/resource' }
  let(:options) do
    {
      read_file: true,
      reader_type: 'raw_text',
      destination_path: 'destination/path'
    }
  end
  
  subject { described_class.new(resource_path, options) }

  describe '#build' do
    let(:reader) { double('Reader') }
    let(:resource_path) { 'path/to/file' }
    let(:resource_paths) { ['path/to/resource'] }
    
    before do
      allow(FileFetcher::Services::Readers::RawText).to receive(:new).and_return(reader) 
      allow(reader).to receive(:read_file).with(resource_path).and_return(resource_paths)
      
      subject.build
    end

    it 'create new FetcherResourcer' do
      expect(subject.resources.first).to be_instance_of(FileFetcher::Models::FetcherResource)
    end
  end
end
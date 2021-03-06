RSpec.describe FileFetcher::Services::FetcherHandler do
  let(:resource) { double('Resource1') }
  let(:fetcher) { double('Fetcher1') }
  let(:fetcher_builder) { double('FetcherBuilder', fetcher: fetcher) }
  let(:options) do
    {
      request_type: 'http',
      dispatch_type: 'local'
    }
  end

  subject { described_class.new(fetcher_builder, options) }

  describe '#build' do
    before do
      allow(fetcher_builder).to receive(:set_resource).with(resource)
      allow(fetcher_builder).to receive(:reset)
    end

    it 'build fetcher' do
      expect(fetcher_builder).to receive(:set_resource).with(resource)
      expect(fetcher_builder).to receive(:reset)

      subject.build([resource]){|x|}
    end
  end

  describe '#fetch_all' do
    let(:fetcher) { double('Fetcher1', resource: resource) }

    before do
      allow(fetcher).to receive(:request)
      allow(fetcher).to receive(:dispatch)
      allow(fetcher).to receive(:fetched?).and_return(true)
      subject.instance_variable_set(:@fetchers, [fetcher])
    end

    it 'make request and dispatch' do
      expect(fetcher).to receive(:resource)
      expect(fetcher).to receive(:fetched?)

      subject.fetch_all{|x|}
    end

    it 'return arrray of objects with resource' do
      expect(subject.fetch_all{|x|}.first.resource).to eq(resource) 
    end

    it 'return array of objects with fetched true' do
      expect(subject.fetch_all{|x|}.first.fetched).to be true 
    end
  end
end
RSpec.describe FileFetcher::Services::FetcherBuilder do
  let(:fetcher_builder) { described_class.new }

  describe '#fetcher' do
    context 'when @fetcher was not instantied' do
      it '@fetcher is nil' do
        expect(fetcher_builder.instance_variable_get(:@fetcher)).to be nil
      end

      it 'return new fetcher instance' do
        expect(fetcher_builder.fetcher).to be_instance_of(FileFetcher::Services::Fetcher)
      end
    end

    context 'when @fetcher was already instantied' do
      let(:fetcher) { FileFetcher::Services::Fetcher.new }

      before { fetcher_builder.instance_variable_set(:@fetcher, fetcher) }

      it 'return the same instance of fetcher' do
        expect(fetcher_builder.fetcher.object_id).to be fetcher.object_id
      end
    end
  end

  describe '#reset' do
    context 'when @fetcher was already instantied' do
      let(:fetcher) {  FileFetcher::Services::Fetcher.new }

      before { fetcher_builder.instance_variable_set(:@fetcher, fetcher) }

      it 'return new instance of fetcher' do
        expect(fetcher_builder.reset.object_id).not_to be fetcher.object_id
      end
    end
  end

  describe '#set_requester' do
    let(:type) { 'http' }

    before { fetcher_builder.set_requester(type) }

    it 'set new requester object to fetcher' do
      expect(fetcher_builder.fetcher.requester).to be_instance_of(FileFetcher::Services::Requesters::Http)
    end
  end

  describe '#set_dispatcher' do
    let(:type) { 'local' }

    before { fetcher_builder.set_dispatcher(type) }

    it 'set new dispatcher object to fetcher' do
      expect(fetcher_builder.fetcher.dispatcher).to be_instance_of(FileFetcher::Services::Dispatchers::Local)
    end
  end
end
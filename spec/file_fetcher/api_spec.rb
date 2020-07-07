RSpec.describe FileFetcher::API do
  describe '#fetch_and_dispatch' do
    let(:resource_paths) do
      ['https://cdn.bulbagarden.net/upload/thumb/3/39/007Squirtle.png/250px-007Squirtle.png']
    end
    let(:image_fixture) { File.open('spec/fixtures/image.png', 'r').read }

    subject { FileFetcher::API.fetch_and_dispatch(resource_paths) }

    before do
      stub_request(:get, resource_paths.first).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: image_fixture, headers: {})
    end

    it { expect(subject.first.fetched).to be true }
  end
end
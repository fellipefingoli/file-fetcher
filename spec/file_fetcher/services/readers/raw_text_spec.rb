RSpec.describe FileFetcher::Services::Readers::RawText do
  describe '#read_file' do
    let(:file_path) { ['spec/fixtures/images_paths.txt'] }

    subject { described_class.new }

    it 'convert lines to array' do
      expect(subject.read_file(file_path)).to eq([
        "https://cdn.bulbagarden.net/upload/thumb/2/21/001Bulbasaur.png/250px-001Bulbasaur.png",
        "https://cdn.bulbagarden.net/upload/thumb/7/73/004Charmander.png/250px-004Charmander.png",
        "https://cdn.bulbagarden.net/upload/thumb/3/39/007Squirtle.png/250px-007Squirtle.png"
      ])
    end
  end
end
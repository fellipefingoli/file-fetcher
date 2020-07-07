require 'fileutils'

RSpec.describe FileFetcher::Services::Dispatchers::Local do
  describe "#dispatch_file" do
    let(:tempfile_path) { 'spec/tmp/image.png' }
    let(:destination_path) { 'spec/tmp/fetched_files/image.png' }

    subject { described_class.new }

    before do
      allow(FileUtils).to receive(:mkdir_p)
      allow(FileUtils).to receive(:mv)
    end

    it 'return object with persisted attribute true' do
      expect(subject.dispatch_file(tempfile_path, destination_path).persisted).to be true
    end
  end
end

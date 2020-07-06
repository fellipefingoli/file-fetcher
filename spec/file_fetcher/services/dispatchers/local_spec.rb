RSpec.describe FileFetcher::Services::Dispatchers::Local do
  describe "#dispatch_file" do
    let(:tempfile_path) { 'spec/fixtures/image.png' }
    let(:destination_path) { 'spec/tmp/image.png' }

    subject { described_class.new }

    it 'return object with persisted attribute true' do
      expect(subject.dispatch_file(tempfile_path, destination_path).persisted).to be true
    end 

    context 'write new file' do
      before { subject.dispatch_file(tempfile_path, destination_path) }

      it 'in destination path' do
        expect(File).to exist(destination_path)
      end

      it 'with same data from tempfile' do
        expect(File.open(tempfile_path, 'rb').read).to eq(
          File.open(destination_path, 'rb').read
        )
      end
    end

    after { File.delete(destination_path) }
  end
end
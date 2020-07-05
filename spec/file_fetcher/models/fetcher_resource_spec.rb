RSpec.describe FileFetcher::Models::FetcherResource do
  subject do
    described_class.new({
      from_path: "/path/to/file",
      to_path: "/path/to/destiny",
      tempfile_path: "/path/to/tempfile"
    })
  end

  describe '#new' do
    it "create a valid new fetcher resource entity" do
      expect(subject.valid?).to be true
    end
  end

  describe '#freeze!' do
    context "when model is freezed" do
      before { subject.freeze! }

      it "freezes attributes from changes" do
        expect { subject.from_path="/new/path/to/file" }.to raise_error(ArgumentError)
        expect { subject.to_path="/new/path/to/file" }.to raise_error(ArgumentError)
        expect { subject.tempfile_path="/new/path/to/file" }.to raise_error(ArgumentError)
      end
    end
  end
end
module FileFetcher::Models
  class FetcherResource
    include ActiveModel::Model

    attr_accessor :from_path, :to_path, :tempfile_path

    validates_presence_of :from_path, :to_path

    %w(from_path to_path tempfile_path).each do |method|
      class_eval <<-EVAL, __FILE__, __LINE__
        def #{method}=(value)
          raise ArgumentError.new("Freezed attribute") if self.freezed?
          @#{method}=value
        end
      EVAL
    end

    def freeze!
      @freezed = true
    end

    def freezed?
      @freezed
    end
  end
end

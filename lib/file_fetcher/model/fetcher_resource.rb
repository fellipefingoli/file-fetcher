require "active_model"

module FileFetcher
  module Model
    class FetcherResource
      include ActiveModel::Model

      attr_reader :from_path, :to_path, :tempfile_path

      validates_presence_of :from_path, :to_path, :tempfile_path

      %w(from_path to_path tempfile_path).each do |method|
        class_eval <<-EVAL, __FILE__, __LINE__
          def #{method}=(value)
            raise ArgumentError.new("Freezed attribute") if self.freezed?
            @#{method}=value
          end
        EVAL
      end

      def freeze!
        @freeze = true
      end

      def freezed?
        @freeze
      end
    end
  end
end
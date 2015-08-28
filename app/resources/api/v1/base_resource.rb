module API
  module V1
    class BaseResource < JSONAPI::Resource
      def as_json(options = {})
        JSONAPI::ResourceSerializer.new(self.class, options).serialize_to_hash(self)
      end

    private

      def current_user
        context[:current_user]
      end
    end
  end
end

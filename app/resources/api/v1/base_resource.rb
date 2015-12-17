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

      class << self
        def readonly
          meta = class << self; self; end

          meta.instance_eval do
            define_method(:updatable_fields){|context| []}
            define_method(:creatable_fields){|context| []}
          end
        end
      end
    end
  end
end

module Helpers
  module Resources
    def json(resource)
      JSONAPI::ResourceSerializer.new(resource.class).serialize_to_hash(resource)
    end
  end
end

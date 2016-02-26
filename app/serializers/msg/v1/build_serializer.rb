# Build serializer
module Msg
  module V1
    class BuildSerializer < ActiveModel::Serializer
      belongs_to :pull_request, serializer: Msg::V1::PullRequestSerializer do
        object.payload.pull_request
      end

      attributes :ssh_public_key, :ssh_private_key

      def pull_request_id
        object.payload.pull_request.id
      end

      def ssh_public_key
        object.repository.public_key
      end

      def ssh_private_key
        object.repository.private_key
      end
    end
  end
end

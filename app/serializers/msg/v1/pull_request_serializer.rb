module Msg
  module V1
    # Pull request serializer
    class PullRequestSerializer < ActiveModel::Serializer
      attributes :base_sha, :head_sha, :branch, :clone_url, :owner, :repo
    end
  end
end

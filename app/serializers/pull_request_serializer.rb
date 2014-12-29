class PullRequestSerializer < ActiveModel::Serializer
  attributes :id, :base_sha, :head_sha,
             :branch, :clone_url, :owner,
             :repo, :slug
end

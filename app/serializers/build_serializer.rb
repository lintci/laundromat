# Build serializer
class BuildSerializer < ActiveModel::Serializer
  has_one :pull_request, serializer: PullRequestSerializer

  attributes :id, :ssh_public_key, :ssh_private_key

  def pull_request
    object.payload.pull_request
  end

  def ssh_public_key
    object.repository.public_key
  end

  def ssh_private_key
    object.repository.private_key
  end
end

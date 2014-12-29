class BuildSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_one :pull_request, serializer: PullRequestSerializer

  attributes :id

  def pull_request
    object.payload.pull_request
  end
end

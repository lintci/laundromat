class BuildSerializer < ActiveModel::Serializer
  has_one :pull_request, serializer: PullRequestSerializer

  attributes :id, :event_id

  def pull_request
    object.payload.pull_request
  end
end

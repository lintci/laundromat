class TaskSerializer < ActiveModel::Serializer
  embed :ids, include: true
  has_one :build, serializer: BuildSerializer

  attributes :id, :type, :status, :language, :linter
end

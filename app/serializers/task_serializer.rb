# Task serializer
class TaskSerializer < ActiveModel::Serializer
  has_one :build, serializer: BuildSerializer

  attributes :id, :type, :status, :language, :tool
end

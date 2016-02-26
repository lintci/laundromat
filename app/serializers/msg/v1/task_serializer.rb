# Task serializer
module Msg
  module V1
    class TaskSerializer < ActiveModel::Serializer
      has_one :build, serializer: Msg::V1::BuildSerializer

      attributes :status, :language, :tool
    end
  end
end

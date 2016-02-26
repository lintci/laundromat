module Msg
  module V1
    # Source file serializer
    class SourceFileSerializer < ActiveModel::Serializer
      belongs_to :build, serializer: Msg::V1::BuildSerializer
      has_many :tasks, serializer: Msg::V1::LintTaskSerializer

      attributes :name, :sha, :source_type, :language, :linters, :modified_lines, :extension, :size,
                 :generated, :vendored, :documentation, :binary, :image
    end
  end
end

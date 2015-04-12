class LintTaskSerializer < TaskSerializer
  class SourceFileSerializer < ActiveModel::Serializer
    attributes :id, :name, :sha, :source_type, :language, :linters, :modified_lines, :extension, :size,
               :generated, :vendored, :documentation, :binary, :image
  end

  has_many :source_files, serializer: SourceFileSerializer
end

class LintTaskSerializer < TaskSerializer
  class ModifiedFileSerializer < ActiveModel::Serializer
    attributes :name, :lines
  end

  has_many :modified_files, serializer: ModifiedFileSerializer
end

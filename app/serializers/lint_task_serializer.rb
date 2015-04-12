# Lint task serializer
class LintTaskSerializer < TaskSerializer
  has_many :source_files, serializer: SourceFileSerializer
end

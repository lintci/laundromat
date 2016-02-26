# Lint task serializer
module Msg
  module V1
    class LintTaskSerializer < TaskSerializer
      has_many :source_files, serializer: Msg::V1::SourceFileSerializer
    end
  end
end

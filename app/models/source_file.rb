# A file in a repository
class SourceFile < ActiveRecord::Base
  belongs_to :build, required: true

  has_many :task_source_files
  has_many :tasks, through: :task_source_files
  has_many :violations

  validates :name, :language, :linters, :source_type, :size, :extension, presence: true
  validates :binary, :generated, :vendored, :documentation, :image, inclusion: {in: [true, false]}

  def add_violations(new_violations)
    violations.push(*new_violations)
  end
end

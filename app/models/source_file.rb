# A file in a repository
class SourceFile < ActiveRecord::Base
  belongs_to :build, required: true

  has_many :task_results
  has_many :tasks, through: :task_results
  has_many :violations

  validates :name, :language, :linters, :source_type, :size, :extension, presence: true
  validates :binary, :generated, :vendored, :documentation, :image, inclusion: {in: [true, false]}
end

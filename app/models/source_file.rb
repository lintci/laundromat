# A file in a repository
class SourceFile < ActiveRecord::Base
  belongs_to :build, required: true

  has_many :task_source_files
  has_many :tasks, through: :task_source_files
  has_many :violations

  validates :name, presence: true
  validates :language, presence: true
  validates :linters, presence: true
  validates :source_type, presence: true
  validates :size, presence: true
  validates :extension, presence: true
  validates :binary, inclusion: {in: [true, false]}
  validates :generated, inclusion: {in: [true, false]}
  validates :vendored, inclusion: {in: [true, false]}
  validates :documentation, inclusion: {in: [true, false]}
  validates :image, inclusion: {in: [true, false]}

  def add_violations(new_violations)
    violations.push(*new_violations)
  end
end

# Issues found for source files
class Violation < ActiveRecord::Base
  belongs_to :source_file, required: true

  validates :message, presence: true
end

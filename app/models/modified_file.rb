class ModifiedFile < ActiveRecord::Base
  belongs_to :lint_task, required: true

  validates_presence_of :name, :lines
end

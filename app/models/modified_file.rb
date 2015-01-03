class ModifiedFile < ActiveRecord::Base
  belongs_to :analysis_task, required: true

  validates_presence_of :name, :lines
end

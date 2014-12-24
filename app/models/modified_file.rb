class ModifiedFile < ActiveRecord::Base
  belongs_to :analysis_task, required: true
end

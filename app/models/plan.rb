class Plan < ActiveRecord::Base
  has_many :subscribers, class_name: 'Owner'
end

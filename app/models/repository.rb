class Repository < ActiveRecord::Base
  belongs_to :owner
  has_many :builds
end

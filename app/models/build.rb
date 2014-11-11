class Build < ActiveRecord::Base
  belongs_to :repository
  has_many :tasks

  def payload=(payload)
    self[:payload] = payload.is_a?(Payload) ? payload.data : payload
  end

  def payload
    Payload.new(self[:payload])
  end
end

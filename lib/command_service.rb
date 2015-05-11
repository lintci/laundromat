# Simple abstraction of common functionality from services
class CommandService
  class << self
    def call(*args)
      new(*args).call
    end
  end

  def transaction
    ActiveRecord::Base.transaction(&Proc.new)
  end

  def call
    transaction do
      perform
    end
  end
end

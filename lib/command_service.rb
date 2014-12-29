class CommandService
  class << self
    def call(*args)
      new(*args).call
    end
  end

  def transaction
    ActiveRecord::Base.transaction(&Proc.new)
  end
end

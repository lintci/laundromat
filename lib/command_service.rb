# Simple abstraction of common functionality from services
class CommandService
  class << self
    def call(*args)
      new(*args).call
    end

    def callback(*names)
      names.each do |name|
        define_method name do |*args, &block|
          @_callbacks ||= Hash.new(->(*){})

          if block
            @_callbacks[__callee__] = block
          else
            @_callbacks[__callee__].call(*args)
          end
        end
      end
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

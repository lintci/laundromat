module Laundromat
  class InsufficientAccess < StandardError
    alias_method :detail, :message

    def initialize(needed:, current:)
      @needed, @current = needed, current
      super(message)
    end

    def title
      'Insufficient access'
    end

    def message
      "Needed #{needed} access. Currently have #{current} access."
    end

  protected

    attr_reader :needed, :current
  end
end

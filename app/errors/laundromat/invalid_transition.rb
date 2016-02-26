module Laundromat
  class InvalidTransition < StandardError
    alias_method :detail, :message

    def initialize(aasm_error, context: '')
      @aasm_error, @context = aasm_error, context
      super(message)
    end

    def title
      'Invalid transition'
    end

    def message
      "Event '#{event_name}' unable to transition from '#{current_state}'.#{context}"
    end

  protected

    attr_reader :aasm_error

  private

    delegate :object, :event_name, :state_machine_name, :failures, to: :aasm_error

    def current_state
      object.aasm(state_machine_name).current_state
    end

    def next_state
    end

    def context
      " #{@context}" if @context.present?
    end
  end
end

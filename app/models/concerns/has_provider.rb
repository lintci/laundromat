module HasProvider
  extend ActiveSupport::Concern

  def provider=(provider)
    self[:provider] = provider.to_s
  end

  def provider
    Provider[self[:provider]]
  end
end

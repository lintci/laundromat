require 'spec_helper'

RSpec.describe Activation, type: :model do
  describe '#initialize' do
    subject(:activation){described_class.new}

    it 'generates an ssh key pair', :aggregate_failures do
      expect(activation.public_key).to be_ssh_public_key
      expect(activation.private_key).to be_private_key
    end
  end

  describe '#valid?' do
    subject(:activation){build(:activation)}

    it 'requires a repository' do
      activation.repository = nil
      expect(activation).to_not be_valid
    end

    it 'requires a public_key' do
      activation.public_key = nil
      expect(activation).to_not be_valid
    end

    it 'requires a private_key' do
      activation.private_key = nil
      expect(activation).to_not be_valid
    end

    it 'requires a deploy_key_id' do
      activation.deploy_key_id = nil
      expect(activation).to_not be_valid
    end

    it 'requires a webhook_id' do
      activation.webhook_id = nil
      expect(activation).to_not be_valid
    end

    it 'requires a provider' do
      activation.provider = nil
      expect(activation).to_not be_valid
    end
  end
end

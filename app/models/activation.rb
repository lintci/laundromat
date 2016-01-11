class Activation < ActiveRecord::Base
  belongs_to :repository, required: true

  validates :public_key, presence: true
  validates :private_key, presence: true
  validates :deploy_key_id, presence: true
  validates :webhook_id, presence: true

  default_scope{order(:created_at)}

  after_initialize :generate_ssh_keys

private

  def generate_ssh_keys
    return if public_key? && private_key?

    key_pair = SSHKey.generate(passphrase: ENV.fetch('SSH_PASSPHRASE'), comment: 'LintCI')
    self.private_key = key_pair.private_key
    self.public_key = key_pair.ssh_public_key
  end
end

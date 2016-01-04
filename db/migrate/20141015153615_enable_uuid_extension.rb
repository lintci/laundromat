class EnableUuidExtension < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' if Rails.env.test? || Rails.env.development?
  end
end

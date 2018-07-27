class ChangeSecureIdToSecretId < ActiveRecord::Migration[5.1]
  def change
    rename_column :lists, :secure_id, :secret_id
  end
end

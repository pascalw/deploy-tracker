class AddApplicationsTokenIndex < ActiveRecord::Migration
  def change
    add_index :applications, :token, unique: true
  end
end

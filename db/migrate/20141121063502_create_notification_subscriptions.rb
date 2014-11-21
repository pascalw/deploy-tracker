class CreateNotificationSubscriptions < ActiveRecord::Migration
  def change
    create_table :notification_subscriptions do |t|
      t.string :name
      t.string :type
      t.string :room_id

      t.references :application
    end
  end
end

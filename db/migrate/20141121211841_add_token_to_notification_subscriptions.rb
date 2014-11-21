class AddTokenToNotificationSubscriptions < ActiveRecord::Migration
  def change
    add_column :notification_subscriptions, :token, :string
  end
end

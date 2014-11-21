class NotificationSubscription < ActiveRecord::Base
  belongs_to :application
end

require './app/models/hipchat_notification_subscription'

require './app/models/notification_subscription'
require './app/models/notifiers/hipchat_notifier'

class HipchatNotificationSubscription < NotificationSubscription
  def notifier
    HipchatNotifier.new
  end
end

require 'sucker_punch'

class DeployNotificationJob
  include SuckerPunch::Job

  def perform(application, subscription)
    subscription.notifier.notify(subscription)
  end
end

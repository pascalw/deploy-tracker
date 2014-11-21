require 'securerandom'
require './app/models/deployment'
require './app/models/notification_subscription'

class Application < ActiveRecord::Base
  has_many :deployments
  has_many :notification_subscriptions

  before_create :create_token

  def track_deployment!
    self.deployments.create

    self.notification_subscriptions.each do |subscription|
      subscription.notifier.notify(subscription)
    end
  end

  private def create_token
    self.token = SecureRandom.hex(8) if self.token.nil?
  end
end

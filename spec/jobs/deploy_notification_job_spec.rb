require 'spec_helper'
require 'sucker_punch/testing/inline'
require './app/jobs/deploy_notification_job'

describe DeployNotificationJob do
  describe '#perform' do
    let(:application)  { double(name: 'myapp') }
    let(:subscription) { double(notifier: double(notify: nil)) }

    it 'calls the subscriptions notifier' do
      DeployNotificationJob.new.perform(application, subscription)

      expect(subscription.notifier).to have_received(:notify).with(application, subscription)
    end
  end
end

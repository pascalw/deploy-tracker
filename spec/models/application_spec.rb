require 'spec_helper'
require 'support/active_record'
require './app/models/application'
require './app/models/notification_subscription'
require './app/jobs/deploy_notification_job'

describe Application do
  subject(:application) { Application.create(name: 'my app') }

  describe '#token' do
    context 'create' do
      it 'generates a token' do
        expect(application.token.length).to eq(16)
      end
    end

    context 'update' do
      before do
        @original_token = application.token
        application.save
      end

      it 'does not overwrite an existing token' do
        expect(application.token).to eq(@original_token)
      end
    end
  end

  describe '#track_deployment!' do
    it 'creates a deployment record' do
      expect { application.track_deployment! }.to change{ application.deployments.count }.by(1)
    end

    it 'creates DeployNotificationJobs for each subscription' do
      subscription1 = stubbed_subscription
      subscription2 = stubbed_subscription
      application.notification_subscriptions << [subscription1, subscription2]

      job = double(async: double(perform: nil))
      allow(DeployNotificationJob).to receive(:new).and_return(job)

      application.track_deployment!

      expect(job.async).to have_received(:perform).with(application, subscription1)
      expect(job.async).to have_received(:perform).with(application, subscription2)
    end
  end

  def stubbed_subscription
    subscription = NotificationSubscription.new
    allow(subscription).to receive(:notifier).and_return(double(notify: nil))

    subscription
  end
end

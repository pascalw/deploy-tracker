require 'spec_helper'
require 'sucker_punch/testing/inline'

describe 'POST /deployments/:token' do
  context 'non existing token' do
    before do
      post "/deployments/foobar"
    end

    it 'responds with 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'existing token' do
    let!(:application) { Application.create(name: 'myapp') }

    before do
      post "/deployments/#{application.token}"
    end

    it 'responds with 204' do
      expect(response.status).to eq(204)
      expect(application.deployments.size).to eq(1)
    end
  end

  context 'with notification subscription' do
    let(:notifier) { double(notify: nil) }

    let!(:application) { Application.create(name: 'myapp') }
    let(:subscription) do
      HipchatNotificationSubscription.new(
        token: 'sometoken',
        room_id: '1234'
      )
    end

    before do
      application.notification_subscriptions << subscription
      allow(HipchatNotifier).to receive(:new).and_return(notifier)

      post "/deployments/#{application.token}"
    end

    it 'calls the notifier' do
      expect(notifier).to have_received(:notify).with(application, subscription)
    end
  end
end

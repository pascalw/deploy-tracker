require 'spec_helper'
require './app/models/notifiers/hipchat_notifier'
require './app/models/application'
require './app/models/notification_subscription'
require 'webmock/rspec'

describe HipchatNotifier do
  let(:application) { Application.new(name: 'myapp', url: 'http://example.org') }
  let(:subscription) do
    NotificationSubscription.new(
      room_id: '997620',
      token: 'mytoken',
      application: application
    )
  end

  describe '#notify' do
    before do
      stub_request(
          :post,
          "https://api.hipchat.com/v2/room/#{subscription.room_id}/notification"
      ).to_return(status: 204)

      HipchatNotifier.new.notify(application, subscription)
    end

    it 'posts to the hipchat api v2' do
      expect(WebMock).to have_requested(:post, "https://api.hipchat.com/v2/room/#{subscription.room_id}/notification").with(
        headers: { 
          'Authorization' => "Bearer #{subscription.token}",
          'Content-Type' => 'application/json'
        },
        body: {
          color: "green",
          notify: true,
          message_format: "html",
          message: %{New <a href="http://example.org">myapp</a> deployment available}
        }.to_json
      )
    end
  end
end

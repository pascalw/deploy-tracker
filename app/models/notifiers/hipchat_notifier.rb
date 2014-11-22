require 'json'
require 'httparty'

class HipchatNotifier
  def notify(application, notification_subscription)
    app_name = application.name
    app_url  = application.url
    room_id  = notification_subscription.room_id
    token    = notification_subscription.token

    payload = {
      color: 'green',
      notify: true,
      message_format: 'html',
      message: %{New <a href="#{app_url}">#{app_name}</a> deployment available}
    }

    HTTParty.post(
      "https://api.hipchat.com/v2/room/#{room_id}/notification",
      headers: {
        'Authorization' => "Bearer #{token}",
        'Content-Type' => 'application/json'
      },
      body: payload.to_json
    )
  end
end

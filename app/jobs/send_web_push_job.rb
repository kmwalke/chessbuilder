class SendWebPushJob < ApplicationJob
  queue_as :default

  def perform(user_id, title, body)
    user = User.find(user_id)

    user.web_push_subscriptions.each do |sub|
      WebPush.payload_send(
        message: { title: title, body: body }.to_json,
        endpoint: sub.endpoint,
        p256dh: sub.p256dh_key,
        auth: sub.auth_key,
        vapid: {
          subject: "mailto:admin@example.com",
          public_key: ENV["WEBPUSH_PUBLIC_KEY"],
          private_key: ENV["WEBPUSH_PRIVATE_KEY"]
        }
      )
    rescue WebPush::ExpiredSubscription, WebPush::InvalidSubscription
      sub.destroy
    end
  end
end
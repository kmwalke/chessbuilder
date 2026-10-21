class SendWebPushJob < ApplicationJob
  queue_as :default

  def perform(user, body)
    user.web_push_subscriptions.each do |sub|
      WebPush.payload_send(
        message: { title: 'ChessBuilder', body: body }.to_json,
        endpoint: sub.endpoint,
        p256dh: sub.p256dh_key,
        auth: sub.auth_key,
        vapid: {
          subject: 'mailto:admin@example.com',
          public_key: ENV.fetch('WEBPUSH_PUBLIC_KEY', nil),
          private_key: ENV.fetch('WEBPUSH_PRIVATE_KEY', nil)
        }
      )
    rescue WebPush::ExpiredSubscription, WebPush::InvalidSubscription
      sub.destroy
    end
  end
end

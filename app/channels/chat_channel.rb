# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:token]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    MessageService.new(content: data["content"],
                       token: data["token"],
                       sender_id: current_user.id,
                       recipient_id: data["recipient_id"].to_i)
                  .perform
  end
end

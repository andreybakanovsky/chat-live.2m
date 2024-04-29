# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:token]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

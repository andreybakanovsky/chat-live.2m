# frozen_string_literal: true

class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "appearance_channel"
  end

  def unsubscribed
    current_user.offline!
  end

  def online
    current_user.online!
  end

  def away
    current_user.away!
  end
end

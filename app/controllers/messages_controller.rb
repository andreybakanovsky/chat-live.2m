# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    message = Message.new message_params
    message.sender = current_user
    message.save!

    SendMessageJob.perform_later(message)
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :recipient_id, :token)
  end
end

# frozen_string_literal: true

class MessageService
  def initialize(content:, token:, sender_id:, recipient_id:)
    @content = content
    @token = token
    @sender_id = sender_id
    @recipient_id = recipient_id
  end

  def perform
    message = create_message!

    SendMessageJob.perform_later(message)
  end

  private

  def create_message!
    Message.create!(content: @content,
                    token: @token,
                    recipient_id: @recipient_id,
                    sender_id: @sender_id)
  end
end

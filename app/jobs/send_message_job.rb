# frozen_string_literal: true

class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    my_message = render_partial('messages/my_message', message)
    their_message = render_partial('messages/their_message', message)

    ActionCable.server.broadcast("chat_channel_#{message.token}", { my_message:, their_message:, message: })
  end

  def render_partial(partial, message)
    ApplicationController.render(partial:, locals: { message: })
  end
end

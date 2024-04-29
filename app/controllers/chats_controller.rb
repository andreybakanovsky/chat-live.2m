# frozen_string_literal: true

class ChatsController < ApplicationController
  def index
    users
  end

  def show
    token
    users_messages
    render 'index'
  end

  private

  helper_method def recipient
    @recipient ||= User.find(params[:id])
  end

  helper_method def users
    @users ||= User.where.not(id: current_user.id)
  end

  def users_messages
    @users_messages ||= if recipient.as_common_chat?
                          Message.common_between(current_user, recipient).includes(:sender).includes(:recipient)
                        else
                          Message.private_between(current_user, recipient).includes(:sender).includes(:recipient)
                        end
  end

  def token
    if recipient.as_common_chat?
      @token = ''
      return
    end

    @token = if users_messages.count.positive?
               users_messages.first.token
             else
               SecureRandom.uuid
             end
  end
end

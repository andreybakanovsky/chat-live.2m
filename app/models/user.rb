# frozen_string_literal: true

class User < ApplicationRecord
  after_update_commit { broadcast_update }

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable
  devise :database_authenticatable, :registerable,
         :validatable, :rememberable

  validates :name, presence: true

  enum :online_status, %i[offline away online], default: :offline

  def as_common_chat?
    email == 'admin@livechat.com'
  end

  def online_status_to_css
    case online_status
    when 'online'
      'border border-white bg-success'
    when 'away'
      'border border-white bg-warning'
    when 'offline'
      'bg-transparent'
    else
      'bg-transparent'
    end
  end

  def broadcast_update
    broadcast_replace_to :appearance_channel, partial: 'users/online_status', user: self
  end
end

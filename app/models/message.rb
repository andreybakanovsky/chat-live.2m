# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :content, presence: true

  scope :private_between, lambda { |current_user, recipient|
                            where('(sender_id = :current_user_id AND recipient_id = :recipient_id)
                           OR (sender_id = :recipient_id AND recipient_id = :current_user_id)',
                                  current_user_id: current_user.id, recipient_id: recipient.id).order(created_at: :asc)
                          }
  scope :common_between, lambda { |current_user, common_chat_user|
                           where('(sender_id = :current_user_id AND recipient_id = :recipient_id)
                              OR (recipient_id = :recipient_id)',
                                 current_user_id: current_user.id, recipient_id: common_chat_user.id).order(created_at: :asc)
                         }
end

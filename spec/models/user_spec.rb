# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of(:name) }

  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "is not valid without an email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is not valid without a password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end
  end

  it { is_expected.to have_many(:sent_messages).class_name('Message').with_foreign_key('sender_id') }
  it { is_expected.to have_many(:received_messages).class_name('Message').with_foreign_key('recipient_id') }

  describe '#as_common_chat?' do
    it 'returns true if the user is identified as a common chat' do
      common_chat_user = build(:user, name: "common chat", email: 'admin@livechat.com')
      expect(common_chat_user.as_common_chat?).to be_truthy
    end

    it 'returns false if the user is not identified as a regular user' do
      user = build(:user)
      expect(user.as_common_chat?).to be_falsey
    end
  end
end

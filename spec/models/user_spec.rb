# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:sent_messages).class_name('Message').with_foreign_key('sender_id') }
  it { is_expected.to have_many(:received_messages).class_name('Message').with_foreign_key('recipient_id') }

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

  describe "online statuses" do
    let(:user) { create(:user) }

    it "creates offline user" do
      expect(user).to be_offline
    end

    it "updates user status to online" do
      user.online!
      expect(user).to be_online
    end

    it "updates user status to away" do
      user.away!
      expect(user).to be_away
    end
  end

  describe '#as_common_chat?' do
    it 'returns true if the user is identified as a common chat' do
      common_chat_user = build(:user, name: "common chat", email: 'admin@livechat.com')
      expect(common_chat_user).to be_as_common_chat
    end

    it 'returns false if the user is not identified as a regular user' do
      user = build(:user)
      expect(user).not_to be_as_common_chat
    end
  end
end

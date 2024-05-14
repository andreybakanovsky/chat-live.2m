# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  # it { is_expected.to validate_presence_of(:name) }

  it 'validates presence of name' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  describe "the sent messages association" do
    let(:association) { described_class.reflect_on_association(:sent_messages) }

    it 'has has_many association' do
      expect(association.macro).to eq(:has_many)
    end

    it 'has Messages class_name' do
      expect(association.options[:class_name]).to eq('Message')
    end

    it 'has the foreign key as sender_id' do
      expect(association.options[:foreign_key]).to eq('sender_id')
    end
  end

  describe "the received messages association" do
    let(:association) { described_class.reflect_on_association(:received_messages) }

    it 'has has_many association' do
      expect(association.macro).to eq(:has_many)
    end

    it 'has Messages class_name' do
      expect(association.options[:class_name]).to eq('Message')
    end

    it 'has the foreign key as recipient_id' do
      expect(association.options[:foreign_key]).to eq('recipient_id')
    end
  end

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

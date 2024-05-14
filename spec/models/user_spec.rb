# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  # it { is_expected.to validate_presence_of(:name) }

  it 'validates presence of name' do
    user = described_class.new(name: nil)
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

  describe 'enum statuses' do
    it "has default online_status as offline" do
      user = build(:user)

      expect(user.online_status).to eq('offline')
    end

    it "changes status to online" do
      user = build(:user)
      user.online!

      expect(user.online_status).to eq('online')
    end

    it "changes status to away" do
      user = build(:user)
      user.away!

      expect(user.online_status).to eq('away')
    end

    it "returns a method error" do
      user = build(:user)

      expect { user.rendom! }.to raise_error(NoMethodError)
    end

    it "returns an attribute error" do
      user = build(:user)

      expect { user.online_status = :rendom }.to raise_error(ArgumentError)
    end
  end

  describe "#broadcast_update" do
    it "broadcasts update to appearance_channel with correct arguments" do
      user = described_class.new # Создаем объект пользователя
      allow(user).to receive(:broadcast_replace_to)

      user.broadcast_update

      expect(user).to have_received(:broadcast_replace_to).with(:appearance_channel, { partial: 'users/online_status', user: })
    end
  end

  describe "#as_common_chat?" do
    it "returns true if the email of common chat" do
      user = build(:user, email: 'admin@livechat.com')

      expect(user.as_common_chat?).to be true
    end

    it "returns false if it's not the common chat email" do
      user = build(:user, email: 'misha@livechat.com')

      expect(user.as_common_chat?).to be false
    end
  end

  describe "#online_status_to_css" do
    it "returns CSS class for the online status" do
      user = build(:user)
      user.online!

      expect(user.online_status_to_css).to eq('border border-white bg-success')
    end

    it "returns CSS class for the offline status" do
      user = build(:user)

      expect(user.online_status_to_css).to eq('bg-transparent')
    end

    it "returns CSS class for the away status" do
      user = build(:user)
      user.away!

      expect(user.online_status_to_css).to eq('border border-white bg-warning')
    end
  end
end

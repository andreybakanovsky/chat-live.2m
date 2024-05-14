# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  describe 'scopes' do
    let(:user) { create(:user) }
    let(:recipient) { create(:user) }
    let(:common_chat) { create(:user, email: "admin@livechat.com") }

    let(:message1) { create(:message, sender: user, recipient:) }
    let(:message2) { create(:message, sender: recipient, recipient: user) }
    let(:common_chat_message) { create(:message, sender: user, recipient: common_chat) }

    it 'validates presence of content' do
      message = described_class.new(content: nil)
      expect(message).not_to be_valid
    end

    it 'validates presence of content with the error' do
      message = described_class.new(content: nil)
      message.valid?
      expect(message.errors[:content]).to include("can't be blank")
    end

    it 'belongs to sender' do
      association = described_class.reflect_on_association(:sender)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to recipient' do
      association = described_class.reflect_on_association(:recipient)
      expect(association.class_name).to eq('User')
    end

    describe '.private_between' do
      let(:messages) { described_class.private_between(user, recipient) }

      it 'returns messages exchanged between two users' do
        expect(messages).to include(message1, message2)
      end

      it 'does not return a common message' do
        expect(messages).not_to include(common_chat_message)
      end
    end

    describe '.common_between' do
      let(:messages) { described_class.common_between(user, common_chat) }

      it 'returns messages exchanged in a common chat' do
        expect(messages).to include(common_chat_message)
      end

      it 'does not return private messages' do
        expect(messages).not_to include(message1, message2)
      end
    end
  end
end

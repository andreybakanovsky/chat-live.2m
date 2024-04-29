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

    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to belong_to(:sender).class_name('User') }
    it { is_expected.to belong_to(:recipient).class_name('User') }

    describe '.private_between' do
      it 'returns messages exchanged between two users' do
        messages = described_class.private_between(user, recipient)
        expect(messages).to include(message1)
        expect(messages).to include(message2)
        expect(messages).not_to include(common_chat_message)
      end
    end

    describe '.common_between' do
      it 'returns messages exchanged in a common chat' do
        messages = described_class.common_between(user, common_chat)
        expect(messages).to include(common_chat_message)
        expect(messages).not_to include(message1)
        expect(messages).not_to include(message2)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Chats" do
  let(:user) { create(:user) }
  let!(:recipient) { create(:user) }
  let!(:user3) { create(:user) }

  before { sign_in user }

  describe "GET /" do
    it 'returns a successful response' do
      get chats_path
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of users' do
      get chats_path
      expect(assigns(:users)).to include(recipient)
    end

    it 'returns a list excluding the current user' do
      get chats_path
      expect(assigns(:users)).not_to include(user)
    end
  end

  describe 'GET /chats/:id' do
    let!(:common_chat) { create(:user, email: "admin@livechat.com") }

    let!(:private_message1) { create(:message, sender: user, recipient:) }
    let!(:private_message2) { create(:message, sender: recipient, recipient: user) }

    let!(:common_message1) { create(:message, sender: user, recipient: common_chat) }
    let!(:common_message2) { create(:message, sender: recipient, recipient: common_chat) }
    let!(:common_message3) { create(:message, sender: user3, recipient: common_chat) }

    context 'when requesting a common chat' do
      it 'returns the exact number of common_messages' do
        get "/chats/#{common_chat.id}"

        expect(assigns(:users_messages).count).to eq(3)
      end

      it 'does not include a private message' do
        get "/chats/#{common_chat.id}"

        expect(assigns(:users_messages)).not_to include(private_message1)
      end

      it 'includes a common message from the first user' do
        get "/chats/#{common_chat.id}"

        expect(assigns(:users_messages)).to include(common_message1)
      end

      it 'includes a common message from the second user' do
        get "/chats/#{common_chat.id}"

        expect(assigns(:users_messages)).to include(common_message2)
      end

      it 'includes a common message from the third user' do
        get "/chats/#{common_chat.id}"

        expect(assigns(:users_messages)).to include(common_message3)
      end
    end

    context 'when requesting a private chat' do
      it 'returns the exact number of private messages' do
        get "/chats/#{recipient.id}"

        expect(assigns(:users_messages).count).to eq(2)
      end

      it 'does not include a common message' do
        get "/chats/#{recipient.id}"

        expect(assigns(:users_messages)).not_to include(common_message3)
      end

      it 'includes a private message from the current user' do
        get "/chats/#{recipient.id}"

        expect(assigns(:users_messages)).to include(private_message1)
      end

      it 'includes a private message from the current interlocutor' do
        get "/chats/#{recipient.id}"

        expect(assigns(:users_messages)).to include(private_message2)
      end
    end
  end
end

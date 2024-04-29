# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/messages' do
  let(:user) { create(:user) }
  let(:recipient) { create(:user) }

  before { sign_in user }

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          message: {
            content: 'text of the message',
            token: '000-000',
            recipient_id: recipient.id
          }
        }
      end

      it 'creates a new Message' do
        expect do
          post messages_path, params: valid_attributes
        end.to change(Message, :count).by(1)
      end

      it 'returns a successful responce' do
        post messages_path, params: valid_attributes
        expect(response).to redirect_to(chats_path(recipient.id))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          message: {
            content: 'text of the message',
            token: '000-000',
            recipient_id: nil
          }
        }
      end

      it 'does not create a new Message' do
        expect do
          post messages_url, params: { message: invalid_attributes }
        end.not_to change(Message, :count)
      end

      it 'returns status unprocessable_entity' do
        post messages_url, params: { message: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

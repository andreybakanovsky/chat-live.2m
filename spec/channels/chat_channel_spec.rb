# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatChannel do
  let(:user) { create(:user) }
  let(:recipient) { create(:user) }
  let(:message) { create(:message, :with_token, recipient:) }

  before do
    stub_connection current_user: user
  end

  it 'successfully confirmed subscription' do
    subscribe(token: message.token)

    expect(subscription).to be_confirmed
  end

  it 'successfully subscribes to a chat stream' do
    subscribe(token: message.token)

    expect(subscription).to have_stream_from("chat_channel_#{message.token}")
  end
end

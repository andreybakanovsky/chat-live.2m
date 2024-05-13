# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageService do
  let(:content) { "Content of the message" }
  let(:token) { "001-010" }
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }

  it 'creates a new message' do
    expect do
      described_class.new(content:, token:, sender_id: sender.id, recipient_id: recipient.id).perform
    end.to change(Message, :count).by(1)
  end

  it 'enqueues SendMessageJob' do
    message_service = described_class.new(content:, token:, sender_id: sender.id, recipient_id: recipient.id)
    allow(SendMessageJob).to receive(:perform_later)
    message_service.perform
    expect(SendMessageJob).to have_received(:perform_later).with(an_instance_of(Message))
  end
end

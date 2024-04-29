# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendMessageJob do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }
  let(:recipient) { create(:user) }
  let(:message) { create(:message, :with_token, recipient:) }

  it 'queues the job' do
    expect do
      described_class.perform_later(message)
    end.to(have_enqueued_job)
  end

  it 'performs the job with the message' do
    expect { perform_enqueued_jobs { described_class.perform_later(message) } }
      .to have_broadcasted_to("chat_channel_#{message.token}")
      .with(a_hash_including(message: hash_including(content: message.content)))
  end
end

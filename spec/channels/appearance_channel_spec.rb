# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AppearanceChannel do
  describe "Appearance Channel specs" do
    let(:user) { create(:user) }

    before do
      stub_connection current_user: user
      subscribe(channel: "AppearanceChannel")
    end

    it 'successfully subscribes to the channel' do
      expect(subscription).to be_confirmed
    end

    it "updates user status to online" do
      perform :online
      expect(user.reload.online_status).to eq("online")
    end

    it 'updates user online status to offline when unsubscribed' do
      perform :online
      expect { unsubscribe }.to change { user.reload.online_status }.to('offline')
    end

    it 'updates user online status to away' do
      perform :online
      expect { perform :away }.to change { user.reload.online_status }.to('away')
    end
  end
end

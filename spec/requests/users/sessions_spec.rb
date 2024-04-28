# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users::Sessions" do
  let(:user) { create(:user) }

  describe "users/sessions#new" do
    it "returns successful response" do
      get "/users/sign_in"
      expect(response).to be_successful
    end
  end

  describe "users/sessions#create" do
    context "with valid params" do
      let(:valid_params) { { user: { email: user.email, password: user.password } } }

      it "logs in the user" do
        post user_session_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { user: { email: user.email, password: "#{user.password}." } } }

      it "doesn't log in the user" do
        post user_session_path, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end

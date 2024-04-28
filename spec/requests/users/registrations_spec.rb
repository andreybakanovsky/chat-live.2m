# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users::Registrations" do
  describe "users/registrations#new" do
    it "returns successful response" do
      get "/users/sign_up"
      expect(response).to be_successful
    end
  end

  describe "users/registrations#create" do
    context "with valid params" do
      let(:valid_params) { { user: attributes_for(:user) } }

      it "create a user" do
        expect do
          post user_registration_path, params: valid_params
        end.to change(User, :count).by(+1)
      end

      it "redirects to the home page" do
        post user_registration_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      let(:invalid_email) { { user: attributes_for(:user, email: "email.com") } }
      let(:invalid_password) { { user: attributes_for(:user, password: "12345") } }

      it "does not create withot an email" do
        expect do
          post user_registration_path, params: invalid_email
        end.not_to change(User, :count)
      end

      it "does not create withot a password" do
        expect do
          post user_registration_path, params: invalid_password
        end.not_to change(User, :count)
      end

      it "renders the registration form again" do
        post user_registration_path, params: invalid_email
        expect(response).to render_template(:new)
      end
    end
  end
end

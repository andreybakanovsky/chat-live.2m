# frozen_string_literal: true

Given "I have a registered account" do
  @user = FactoryBot.create(:user)
end

When "I sign in with valid credentials" do
  visit new_user_session_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  find_button('Log in').click
end

Then "I should be redirected to the root page" do
  expect(page).to have_current_path(root_path)
end

When "I sign in with invalid credentials" do
  visit new_user_session_path
  fill_in "Email", with: "misha@live.com"
  fill_in "Password", with: "123456."
  find_button('Log in').click
end

Then "I should be redirected to the new session page" do
  expect(page).to have_current_path(new_user_session_path)
end

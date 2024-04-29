# frozen_string_literal: true

Given 'user is logged in' do
  @user = FactoryBot.create(:user, name: 'Misha', email: 'misha@livechat.com')
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  find_button('Log in').click
end

Given "I am on the home page" do
  visit "/"
end

Then "I should see {string}" do |content|
  expect(page).to have_content(content)
end

# frozen_string_literal: true

Given 'USER_1 is logged in' do
  @first_user = FactoryBot.create(:user, name: 'Misha', email: 'misha@livechat.com')
  visit new_user_session_path
  fill_in 'Email', with: @first_user.email
  fill_in 'Password', with: @first_user.password
  find_button('Log in').click
end

Given 'USER_2 exists' do
  @second_user = FactoryBot.create(:user, name: 'Anna', email: 'anna@livechat.com')
end

Given 'USER_3 exists' do
  @third_user = FactoryBot.create(:user, name: 'Fedor', email: 'fedor@livechat.com')
end

Given('COMMON chat exists') do
  @common_chat = FactoryBot.create(:user, name: 'All users', email: 'admin@livechat.com')
end

Given('the USER_1 is on the chats page') do
  visit chats_path
end

Then "he should see the user's name" do
  expect(page).to have_css('span', text: @second_user.name)
end

Then "he should see the common chat's name" do
  expect(page).to have_css('span', text: @common_chat.name)
end

# USER_1 message to the USER_2
When "he clicks on the link to USER_2 chat" do
  find('.chat-link', text: @second_user.name).click
end

Then 'he can write message {string} to USER_2' do |content|
  fill_in 'message-input', with: content
end

When "clicks the send button here in USER_2 chat" do
  find_button('Send').click
end

When "he should stay on the current page" do
  expect(page).to have_current_path("/chats/#{@second_user.id}")
end

Then 'the {string} should appear in the USER_2 chat' do |content|
  expect(page).to have_content content
end

# Message to the COMMON chat
When "USER_1 clicks on the link to COMMON chat" do
  find('.chat-link', text: @common_chat.name).click
end

Then 'he can write message {string} in COMMON chat' do |content|
  fill_in 'message-input', with: content
end

When "clicks the send button here in COMMON chat" do
  find_button('Send').click
end

Then 'the message {string} should appear in COMMON chat' do |content|
  expect(page).to have_content content
end

# Check messages by USER_2
Then 'USER_1 is logget out' do
  find_button('Log out').click
end

And 'USER_2 is logged in' do
  fill_in 'Email', with: @second_user.email
  fill_in 'Password', with: @second_user.password
  find_button('Log in').click
end

Then "USER_2 can see the USER_1 chat's name" do
  expect(page).to have_css('span', text: @first_user.name)
end

And "he can see the COMMON chat's name" do
  expect(page).to have_css('span', text: @common_chat.name)
end

When "he clicks on the link to USER_1 chat" do
  find('.chat-link', text: @first_user.name).click
end

Then 'the {string} appears in the USER_1 chat' do |content|
  expect(page).to have_content content
end

When "he clicks on the link to COMMON chat" do
  find('.chat-link', text: @common_chat.name).click
end

Then 'the {string} appears in the COMMON chat' do |content|
  expect(page).to have_content content
end

# Check messages by USER_3
Then 'USER_2 is logget out' do
  find_button('Log out').click
end

And 'USER_3 is logged in' do
  fill_in 'Email', with: @third_user.email
  fill_in 'Password', with: @third_user.password
  find_button('Log in').click
end

Then "USER_3 can see the USER_1 chat's name" do
  expect(page).to have_css('span', text: @first_user.name)
end

And "USER_3 can see the USER_2 chat's name" do
  expect(page).to have_css('span', text: @second_user.name)
end

And "USER_3 can see the COMMON chat's name" do
  expect(page).to have_css('span', text: @common_chat.name)
end

When "USER_3 clicks on the link to USER_1 chat" do
  find('.chat-link', text: @first_user.name).click
end

Then "{string} or {string} does not appears in the USER_1 chat" do |content1, content2|
  expect(page).to have_no_content content1
  expect(page).to have_no_content content2
end

When "USER_3 clicks on the link to USER_2 chat" do
  find('.chat-link', text: @second_user.name).click
end

Then "{string} or {string} does not appears in the USER_2 chat" do |content1, content2|
  expect(page).to have_no_content content1
  expect(page).to have_no_content content2
end

When "USER_3 clicks on the link to COMMON chat" do
  find('.chat-link', text: @common_chat.name).click
end

Then "USER_3 can the {string} appears in the COMMON chat" do |content|
  expect(page).to have_content content
end

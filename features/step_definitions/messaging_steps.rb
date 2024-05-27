# frozen_string_literal: true

require 'capybara/rails'

# Another whay of arranging sessions is: session = Capybara::Session.new(:selenium, Capybara.app),
#   Capybara.app is the mandatory attribute!
#  see https://github.com/teamcapybara/capybara/tree/master?tab=readme-ov-file#using-sessions
#  or https://www.rubydoc.info/gems/capybara/Capybara/Session

Допустим "имеется ОБЩИЙ чат" do
  @common_chat = FactoryBot.create(:user, name: 'All users', email: 'admin@livechat.com')
end

И "имеются ПОЛЬЗОВАТЕЛИ" do
  @first_user = FactoryBot.create(:user, name: 'Misha', email: 'misha@livechat.com')
  @second_user = FactoryBot.create(:user, name: 'Anna', email: 'anna@livechat.com')
  @third_user = FactoryBot.create(:user, name: 'Fedor', email: 'fedor@livechat.com')
end

И 'ПОЛЬЗОВАТЕЛЬ_1 вошел в систему' do
  log_in @first_user
end

И 'ПОЛЬЗОВАТЕЛЬ_2 вошел в систему' do
  log_in @second_user
end

И 'ПОЛЬЗОВАТЕЛЬ_3 вошел в систему' do
  log_in @third_user
end

# User_1 session
Допустим 'ПОЛЬЗОВАТЕЛЬ_1 находится на странице чатов' do
  use_session_for(@first_user)
  visit chats_path
end

Тогда "он должен видеть имя пользователя" do
  expect(page).to have_css('span', text: @second_user.name)
end

И "он должен видеть название общего чата" do
  expect(page).to have_css('span', text: @common_chat.name)
end

## USER_1 message to the USER_2
Когда "он нажимает на ссылку для чата с ПОЛЬЗОВАТЕЛЕМ_2" do
  find('.chat-link', text: @second_user.name).click
end

Тогда 'он может написать сообщение {string} ПОЛЬЗОВАТЕЛЮ_2' do |content|
  fill_in 'message-input', with: content
end

Когда "нажимает кнопку отправки сообщения в чате ПОЛЬЗОВАТЕЛЯ_2" do
  find_button('Send').click
end

Тогда "он должен остаться на текущей странице" do
  expect(page).to have_current_path("/chats/#{@second_user.id}")
end

И '{string} должно появиться в чате ПОЛЬЗОВАТЕЛЯ_2' do |content|
  expect(page).to have_content content
end

# Message to the COMMON chat
Когда "ПОЛЬЗОВАТЕЛЬ_1 нажимает на ссылку для общего чата" do
  find('.chat-link', text: @common_chat.name).click
end

Тогда "он может написать сообщение {string} в общем чате" do |content|
  fill_in 'message-input', with: content
end

Когда "нажимает кнопку отправки здесь в общем чате" do
  find_button('Send').click
end

Тогда 'сообщение {string} должно появиться в общем чате' do |content|
  expect(page).to have_content content
end

# Check messages by USER_2
Дано "ПОЛЬЗОВАТЕЛЬ_2 может видеть имя чата с ПОЛЬЗОВАТЕЛЕМ_1" do
  use_session_for(@second_user)
  expect(page).to have_css('span', text: @first_user.name)
end

И "он может видеть название общего чата" do
  expect(page).to have_css('span', text: @common_chat.name)
end

Когда "он нажимает на ссылку для чата с ПОЛЬЗОВАТЕЛЕМ_1" do
  find('.chat-link', text: @first_user.name).click
end

Тогда '{string} появляется в чате ПОЛЬЗОВАТЕЛЯ_1' do |content|
  expect(page).to have_content content
end

Когда "он нажимает на ссылку для общего чата" do
  find('.chat-link', text: @common_chat.name).click
end

Тогда '{string} появляется в общем чате' do |content|
  expect(page).to have_content content
end

# Check messages by USER_3
Дано "ПОЛЬЗОВАТЕЛЬ_3 может видеть имя чата с ПОЛЬЗОВАТЕЛЕМ_1" do
  use_session_for(@third_user)
  expect(page).to have_css('span', text: @first_user.name)
end

И "ПОЛЬЗОВАТЕЛЬ_3 может видеть имя чата с ПОЛЬЗОВАТЕЛЕМ_2" do
  expect(page).to have_css('span', text: @second_user.name)
end

И "ПОЛЬЗОВАТЕЛЬ_3 может видеть имя общего чата" do
  expect(page).to have_css('span', text: @common_chat.name)
end

Когда "ПОЛЬЗОВАТЕЛЬ_3 нажимает на ссылку для чата с ПОЛЬЗОВАТЕЛЕМ_1" do
  find('.chat-link', text: @first_user.name).click
end

Тогда "{string} или {string} не появляется в чате ПОЛЬЗОВАТЕЛЯ_1" do |content1, content2|
  expect(page).to have_no_content content1
  expect(page).to have_no_content content2
end

Когда "ПОЛЬЗОВАТЕЛЬ_3 нажимает на ссылку для чата с ПОЛЬЗОВАТЕЛЕМ_2" do
  find('.chat-link', text: @second_user.name).click
end

Тогда "{string} или {string} не появляется в чате ПОЛЬЗОВАТЕЛЯ_2" do |content1, content2|
  expect(page).to have_no_content content1
  expect(page).to have_no_content content2
end

Когда "ПОЛЬЗОВАТЕЛЬ_3 нажимает на ссылку для общего чата" do
  find('.chat-link', text: @common_chat.name).click
end

Тогда "ПОЛЬЗОВАТЕЛЬ_3 видит {string} в общем чате" do |content|
  expect(page).to have_content content
end

# Log out all users
Когда 'ПОЛЬЗОВАТЕЛЬ_1 выходит из системы' do
  use_session_for(@first_user)
  find_button('Log out').click
end

Тогда "ПОЛЬЗОВАТЕЛЬ_1 должен выйти и увидеть страницу входа" do
  expect(page).to have_current_path(new_user_session_path)
end

Когда 'ПОЛЬЗОВАТЕЛЬ_2 выходит из системы' do
  use_session_for(@second_user)
  find_button('Log out').click
end

Тогда "ПОЛЬЗОВАТЕЛЬ_2 должен выйти и увидеть страницу входа" do
  expect(page).to have_current_path(new_user_session_path)
end

Когда 'ПОЛЬЗОВАТЕЛЬ_3 выходит из системы' do
  use_session_for(@third_user)
  find_button('Log out').click
end

Тогда "ПОЛЬЗОВАТЕЛЬ_3 должен выйти и увидеть страницу входа" do
  expect(page).to have_current_path(new_user_session_path)
end

def use_session_for(user)
  Capybara.session_name = "#{user.email}_session"
end

def log_in(user)
  use_session_for(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  find_button('Log in').click
end

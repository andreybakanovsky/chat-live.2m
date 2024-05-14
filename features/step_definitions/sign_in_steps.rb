# frozen_string_literal: true

Допустим "у меня есть зарегистрированный аккаунт" do
  User.create(name: "Миша", email: 'misha@livechat.com', password: '123456', password_confirmation: '123456')
end

Когда "я вхожу с email {string} и паролем {string}" do |email, password|
  valid_params = { email:, password: }
  log_in_with valid_params
end

Тогда "я должен быть перенаправлен на главную страницу" do
  expect(page).to have_current_path(root_path)
end

Когда "я вхожу с email {string} и неверным паролем {string}" do |email, password|
  valid_params = { email:, password: }
  log_in_with valid_params
end

Тогда "я должен быть перенаправлен на страницу новой сессии" do
  expect(page).to have_current_path(new_user_session_path)
end

def log_in_with(params)
  visit new_user_session_path
  fill_in 'Email', with: params[:email]
  fill_in 'Password', with: params[:password]
  find_button('Log in').click
end

# frozen_string_literal: true

Дано 'пользователь имеет зарегистрированный аккаунт' do
  User.create(name: "Миша", email: 'misha@livechat.com', password: '123456')
end

Когда "пользователь входит с email {string} и паролем {string}" do |email, password|
  visit new_user_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  find_button('Log in').click
end

Тогда "он должен быть перенаправлен на домашнюю страницу" do
  visit root_path
end

И "он должен видеть {string}" do |content|
  expect(page).to have_content(content)
end

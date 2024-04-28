# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.delete_all
User.create!(name: 'Все пользователи',
             email: 'admin@livechat.com',
             password: '123436',
             password_confirmation: '123436')
User.create!(name: 'Миша',
             email: 'misha@livechat.com',
             password: '123456',
             password_confirmation: '123456')
User.create!(name: 'Анна',
             email: 'anna@livechat.com',
             password: '123456',
             password_confirmation: '123456')
User.create!(name: 'Федор',
             email: 'fedor@livechat.com',
             password: '123456',
             password_confirmation: '123456')

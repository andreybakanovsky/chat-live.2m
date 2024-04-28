# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable
  devise :database_authenticatable, :registerable,
         :validatable, :rememberable
  validates :name, presence: true
end

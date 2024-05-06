# frozen_string_literal: true

class AddOnlinStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :online_status, :integer, default: 0
  end
end

class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.text :token
      t.references :sender, foreign_key: { to_table: :users }
      t.references :recipient, foreign_key: { to_table: :users }
      
      t.timestamps
    end
  end
end

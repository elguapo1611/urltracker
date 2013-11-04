class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url, :null => false, :unique => true
      t.integer :user_id, :null => false
      t.timestamps
    end
  end
end

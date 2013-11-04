class CreateCrawls < ActiveRecord::Migration
  def change
    create_table :crawls do |t|
      t.integer :page_id, :null => false
      t.text :body
      t.timestamps
    end
  end
end

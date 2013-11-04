class CreateDomSelectors < ActiveRecord::Migration
  def change
    create_table :dom_selectors do |t|
      t.integer :page_id
      t.string :path
      t.timestamps
    end
  end
end

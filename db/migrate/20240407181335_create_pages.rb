class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :url
      t.text :assets
      t.text :links
      t.boolean :crawled

      t.timestamps
    end
  end
end

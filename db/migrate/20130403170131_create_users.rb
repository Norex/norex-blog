class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :blog_name
      t.text :description
      t.text :photo

      t.timestamps
    end
  end
end

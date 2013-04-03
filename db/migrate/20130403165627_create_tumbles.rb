class CreateTumbles < ActiveRecord::Migration
  def change
    create_table :tumbles do |t|
      t.text :title
      t.text :content
      t.datetime :date
      t.integer :tumblr_id
      t.text :url
      t.string :content_type
      t.references :user

      t.timestamps
    end
    add_index :tumbles, :user_id
  end
end

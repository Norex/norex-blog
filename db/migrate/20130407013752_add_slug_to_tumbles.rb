class AddSlugToTumbles < ActiveRecord::Migration
  def change
    add_column :tumbles, :slug, :string
    add_index :tumbles, :slug, unique: true
  end
end

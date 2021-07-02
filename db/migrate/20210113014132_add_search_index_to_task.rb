class AddSearchIndexToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :search, :string
    add_index :tasks, :search
  end
end

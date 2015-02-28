class RemoveMaleColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :male
  end
end

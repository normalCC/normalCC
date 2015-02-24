class AddColumnToSearchesTime < ActiveRecord::Migration
  def change
    add_column :searches, :name, :string
    add_column :searches, :part, :string
  end
end

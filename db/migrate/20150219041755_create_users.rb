class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.date :birth_year
      t.boolean :female
      t.references :country, index: true

      t.timestamps null: false
    end
    add_foreign_key :users, :countries
  end
end

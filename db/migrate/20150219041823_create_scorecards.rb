class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
      t.references :user, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
    add_foreign_key :scorecards, :users
    add_foreign_key :scorecards, :answers
  end
end

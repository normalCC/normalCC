class ChangeTextToStringForAnswerTitle < ActiveRecord::Migration
  def change
    remove_column :answers, :title
    add_column :answers, :title, :string
  end
end

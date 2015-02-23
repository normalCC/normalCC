class AddLikeCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :like, :boolean
  end
end

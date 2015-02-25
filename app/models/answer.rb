class Answer < ActiveRecord::Base
  belongs_to :question

  validates :title, presence: true, uniqueness: {scope: :question_id}
  validate :stop_words
end
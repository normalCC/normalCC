class Answer < ActiveRecord::Base
  belongs_to :question

  validates :title, presence: true, uniqueness: {scope: :question_id}
  validate :stop_words

  private
  
  def stop_words
    if title.present? && title.include?("monkey")
    errors.add(:title, "Please don't use monkey!")
    end
  end
end
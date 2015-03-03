class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :scorecards, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :question_id}
  #validate :stop_words

  #private
  #  def stop_words
  #       if title.present? && title.include?('fuck', 'anal', 'anus', 'arse', 'ass', 'balls', 'bitch', 'blowjob', 'cock', 'boner', 'boob', 'bum', 'clit', 'cunt', 'damn', 'dildo', 'dyke', 'fag', 'goddamn', 'shit', 'homo', 'jerk', 'jiz', 'nigger', 'shit', 'twat', 'vagina', 'whore', 'buttplug')
  #    errors.add(:title, "Please keep the profanity to a minimum!")
  #  end
  #end
end
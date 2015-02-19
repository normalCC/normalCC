class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: { message: "Question content must be provided."}, uniqueness: true

  before_save :cap_title

  def cap_title
    self.title.capitalize!  
  end

end

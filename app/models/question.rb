class Question < ActiveRecord::Base
  belongs_to :user

  # Question has many Answers, which is also a nested attribute on Q.
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                            reject_if: lambda { |x|
                            x[:title].blank? }
  validates :answers, presence: true


  validates :title, presence: { message: "Question content must be provided."}, uniqueness: true

  before_save :cap_title

  def cap_title
    self.title.capitalize!  
  end

  def self.search(search)
    if search
      self.where("title iLIKE ?", "%#{search}%")
      #self.where("title ilike :q", q: search)
      #self.where("title @@ or title @@", "%#{search}%")
    else
      self.all
    end
  end

  def self.text_search(query) 
    if query
      #where("title @@ :q or title @@ :q", q: query) #or content @@ :q",
      where("title iLIKE :q or title iLIKE :q", q: query) #can't search multiple words
    else
      #scoped
    end
  end

end
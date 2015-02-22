class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

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

  # constructs a 2D array of data points to create the graph of results
  def graph_data   
    data_points =[]  # this will have [answer.title, answer.count]
    self.answers.each do |a|
      data_points.push([ a.title, Scorecard.where(answer_id: a.id).count  ])  # a.id removed
    end
    return data_points
  end

end

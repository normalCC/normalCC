class Question < ActiveRecord::Base
  belongs_to :user

  # Question has many Answers, which is also a nested attribute on Q.
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                            reject_if: lambda { |x|
                            x[:title].blank? }, allow_destroy: true
#  validates :answers, presence: true

  #validates :title, presence: { message: "Question content must be provided."}, uniqueness: true
  validates :title, presence: true, allow_blank: false, uniqueness: {case_sensitive: false}

# need to temp disable :title and :answers validation for Rake Task to run properly.
#  validates :title, presence: { message: "Question content must be provided."}, uniqueness: true

  before_save :cap_title
  #validates :title, presence: true, length: {minimum: 5, maximum: 30}
  scope :where_title, lambda { |term| where("questions.title iLIKE ?", "%#{term}%") }

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
  def self.not_time(parts)
      if parts
        where.not("title @@ :s", s: parts )
      end
  end
  def self.time_search(words)

    if words
      where("title @@ :s", s: words )
      #where("title iLIKE :s or title iLIKE :q", q: "%#{words}%", s: "%#{words}%" )
      #where("title iLIKE :s or title iLIKE :q or title iLIKE :b or title iLIKE :n",
      #q: "%#{words}%", s: "%#{words}%", b: "%#{words}%", n: "%#{words}%")
    end
  end
        #words.split(" ").each do |word|
        #words += "OR "
        #end
  def self.text_search(query) 
    if query
      
      where("title @@ :s or title @@ :q", q: "%#{query}%", s: "%#{query}%" ) #or content @@ :q",
      #where("title iLIKE :q or title iLIKE :q", q: "%#{query}%") #can't search multiple words
      #where("title iLIKE :q or title iLIKE :q", q: query) #can't search multiple words
      #how do i split it?
      # where to_tsvector(title,)
      # where plain_tsquery? # Takes a string converts it to lexemes; then ANDS them together
      #And what about useing the right stemmer? and langauge?
      #SELECT title from questions WHERE to_tsvector('english_stem', title) @@ to_tsquery(english, "food"); title
      #SELECT to_tsvector(:title) @@ to_tsquery(query) 
      #what about pg_trgm for mispelled words.
    else
      render 'new'
    end
  end

  # constructs a 2D array of data points to create the graph of results
  def graph_data   
    data_points =[]  # this will have [answer.title, answer.count]
    self.answers.each do |a|
      data_points.push([ a.id, Scorecard.where(answer_id: a.id).count, a.title ])  # a.id removed
    end
    return data_points
  end

end

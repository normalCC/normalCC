class Question < ActiveRecord::Base
  belongs_to :user
  FORW = ['fuck', 'anal', 'anus', 'arse','ass', 'bitch', 'blowjob', 'cock', 'boner', 'boob', 'bum','clit', 'cunt', 'damn', 'dildo', 'dyke', 'fag', 'goddamn', 'shit', 'homo', 'jerk', 'jiz', 'nigger', 'shit', 'twat', 'vagina', 'whore', 'buttplug']
  # Question has many Answers, which is also a nested attribute on Q.
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                            reject_if: lambda { |x|
                            x[:title].blank? }, allow_destroy: true
#  validates :answers, presence: true

  #validates :title, presence: { message: "Question content must be provided."}, uniqueness: true
  validates :title, presence: true, allow_blank: false, uniqueness: {case_sensitive: false}
#  validate :stop_words
#  need to temp disable :title and :answers validation for Rake Task to run properly.
#  validates :title, presence: { message: "Question content must be provided."}, uniqueness: true
  #validates_each :title do |stop_words|
  #end
  #validates_each :title do |stop_words|
  #  record.errors.add(stop_words, 'plus') #if value =~ /\A[a-z]/
  #end
  #What about validates with/?????????? 
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
    data_points =[]  # this will hold [x,y, x.title]
    # a counter number is used to be the "x" values, so that a trend curve
    # can be calculated. Google charts need this to be a number, not a string.
    counter = 0
    self.answers.each do |a|
      counter +=1
      data_points.push([ counter, Scorecard.where(answer_id: a.id).count, a.title ])
    end
    #return data_points only if for early return
    data_points
  end

  def check_words
    FORW.all? do |word|
      self.title.include? word
    end
  end

    private
      #def stop_words
      #  #if title.present? && !check_words.present?
      # if check_words
      #    errors.add(:title, "Please don't use profanity!")
      #  end
      #end
      #def stop_words
      #  if title.present? && title.include?(:title)
      #    errors.add(:title, "has been restricted from use.")
      #  end
      #end

  # This code is used to take the user from the question they've answered
  # to the next question.
  def self.next(question)
    next_question_to_go_to = where('id > ?', question.id).first
    # check that there is indeed another question to go to, otherwise...
    if !next_question_to_go_to 
      # send the user to the "end of all questions page"
      next_question_to_go_to = "finished_all_questions"
    end
    next_question_to_go_to
  end 
      
end

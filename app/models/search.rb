class Search < ActiveRecord::Base

  #def questions
  #  @questions ||= find_questions
  #end

  def self.text_search(query) 
    if query
      #where("title @@ :q or title @@ :q", q: "%#{query}%") #or content @@ :q",
      where("title iLIKE :q", q: "%#{query}%") #can't search multiple words
      #how do i split it?
    end
  end

    private
    def find_questions
      #self.where("title iLIKE ?", "%#{title}%")
      #questions = Question.where("title like ?", "%#{keywords}%") if keywords.present?
      #questions = Question.where("title iLIKE ?", "%#{title}%") if title.present?
      #questions = Question.where("title like ?", "%#{name}%") if keywords.present?
      #questions = Question.where("title  ?", "%#{part}%") if title.present?
      #questions
    end
end

#def self.search(search)
#    if search
#      self.where("title iLIKE ?", "%#{search}%")
#      #self.where("title ilike :q", q: search)
#      #self.where("title @@ or title @@", "%#{search}%")
#    else
#      self.all
#    end
#  end
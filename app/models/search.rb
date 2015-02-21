class Search < ActiveRecord::Base

  def questions
    @questions ||= find_questions
  end

    private
    def find_questions
      questions = questions.where("title like ?", "%#{keywords}%") if keywords.present?
      questions = questions.where("name iLIKE ?", "%#{title}%") if title.present?
      questions
    end
end

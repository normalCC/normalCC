class QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :update, :show, :destroy]
  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save

    else

    end
  end

  def edit
    #find_question
  end

  def update
    #find_question
    if @question.update question_params

    else

    end
  end

  def show
    #find_question
  end

  def index
    @entire_questions = Question.all
  end

  def destroy
    #find_question
    @question.destroy

  end


  private 

    def find_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, {country_ids: []})
    end

end

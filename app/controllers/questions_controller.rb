class QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :update, :show, :destroy]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to @question, notice: "Question created successfully."
    else
      render :new
    end
  end

  def edit
    #find_question
  end

  def update
    #find_question
    if @question.update question_params
      redirect_to @question, notice: "Question updated successfully."
    else
      render :edit
    end
  end

  def show
    #find_question
  end

  def index
    @entire_questions = Question.all

    if (Question.count >= 3)
      @questions_recent = Question.recent(3)
    else
      @questions_recent = @entire_questions
    end
  end

  def destroy
    #find_question
    @question.destroy
    redirect_to questions_path, notice: "Question deleted successfully."
  end


  private
    def find_question
      @question = Question.find(params[:id])
    end
    def question_params
      params.require(:question).permit(:title, {country_ids: []})
    end
end
